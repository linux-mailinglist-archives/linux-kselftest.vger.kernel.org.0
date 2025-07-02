Return-Path: <linux-kselftest+bounces-36358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91ABAF62C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 21:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB884A524C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B12E4990;
	Wed,  2 Jul 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="QeWC5bpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1397224B01;
	Wed,  2 Jul 2025 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485224; cv=none; b=QunG3RL47zJG6Uhz01CnJHEghGDDnkwP1slJ1kJScYgXZzl8lVJvos6Xs6IyYxAtOLJIdAoR1NJfha7pMDH6gODTQQe3KJbCleoIyhHUjTVATFEJLe952bPbiBw8E9mc1iSXCqJBhRcNXFhLHYfUrw2HpVy6puAjdm2fS0hfhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485224; c=relaxed/simple;
	bh=mqTQoihTCIvuzKDNVihAlNO+Z3+bSvYgDiE8xFogLFg=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dPsZPyf0E3SpNWhTZlvSl8vcBcusDFk1hTDO1HmoR9SM/6zxTPXx8bSpbCKLPB7uiyxg5P5+CqohnbJgEl5lsyXgD0nPUU4hxZzglVCXAFzORABYYoAlmAHCyfxoLkEKMXoZjKclYpzpWqB5uzLDZEGtJf9vZV4Xb4NIABwoLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=QeWC5bpI; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751484765;
	bh=mqTQoihTCIvuzKDNVihAlNO+Z3+bSvYgDiE8xFogLFg=;
	h=Date:From:Cc:Subject:From;
	b=QeWC5bpIFMZA/QSzmGOa72YIhdmADCQcnuUtJEKvzr1n7BK1NkdSz8dI5J5Qm6XQB
	 w2LlWmtfzawVvimSBQj10R0qYJd+G+GvpdVePpxXkpnI9vXWsiR/VCJuJt1ji8LAnN
	 AVZi43ovZpWL+XV9xBOlrgMDmdVXfyiY0fconOpFimqwYXscsrvJYJcwAXo3ukZHpe
	 hyfSeGqU60PLGr68YIw3rTcJYPFEHNW8Urq1+da8UCpyOXdSsalrD/4U2OwNh/V7JQ
	 kU/0TV94RpGTK4M3TE+iXP9EB2Z/jLdhjSFWKdBeMiaZ8O7pdENTlTi5CDQQ8yWRO5
	 iYN3Z3RQ36NdA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 586B641A;
	Wed,  2 Jul 2025 21:32:45 +0200 (CEST)
Date: Wed, 2 Jul 2025 21:32:45 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Chas Williams <3chas3@gmail.com>, Coly Li <colyli@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Don Brace <don.brace@microchip.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-sh@vger.kernel.org, netdev@vger.kernel.org, 
	linux-bcache@vger.kernel.org, storagedev@microchip.com, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, ocfs2-devel@lists.linux.dev, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net
Subject: [PATCH] global: fix misapplications of "awhile"
Message-ID: <h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b64xojk44rmwat7t"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--b64xojk44rmwat7t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Of these:
  7 "for a while" typos
  5 "take a while" typos
  1 misreading of "once in a while"?

3 awhiles used correctly remain in the tree

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/trace/histogram.rst             | 2 +-
 arch/sh/drivers/pci/common.c                  | 2 +-
 arch/sh/drivers/pci/pci-sh7780.c              | 2 +-
 drivers/atm/lanai.c                           | 2 +-
 drivers/md/bcache/bcache.h                    | 2 +-
 drivers/md/bcache/request.c                   | 2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 2 +-
 drivers/scsi/hpsa.c                           | 2 +-
 drivers/tty/serial/jsm/jsm_neo.c              | 2 +-
 fs/ocfs2/dlm/dlmrecovery.c                    | 2 +-
 sound/pci/emu10k1/emu10k1_main.c              | 2 +-
 sound/pci/emu10k1/emupcm.c                    | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histog=
ram.rst
index 0aada18c38c6..2b98c1720a54 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -249,7 +249,7 @@ Extended error information
   table, it should keep a running total of the number of bytes
   requested by that call_site.
=20
-  We'll let it run for awhile and then dump the contents of the 'hist'
+  We'll let it run for a while and then dump the contents of the 'hist'
   file in the kmalloc event's subdirectory (for readability, a number
   of entries have been omitted)::
=20
diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index 9633b6147a05..f95004c67e6c 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -148,7 +148,7 @@ unsigned int pcibios_handle_status_errors(unsigned long=
 addr,
=20
 		cmd |=3D PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
=20
-		/* Now back off of the IRQ for awhile */
+		/* Now back off of the IRQ for a while */
 		if (hose->err_irq) {
 			disable_irq_nosync(hose->err_irq);
 			hose->err_timer.expires =3D jiffies + HZ;
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7=
780.c
index 9a624a6ee354..f41d6939a3d9 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -153,7 +153,7 @@ static irqreturn_t sh7780_pci_serr_irq(int irq, void *d=
ev_id)
 	/* Deassert SERR */
 	__raw_writel(SH4_PCIINTM_SDIM, hose->reg_base + SH4_PCIINTM);
=20
-	/* Back off the IRQ for awhile */
+	/* Back off the IRQ for a while */
 	disable_irq_nosync(irq);
 	hose->serr_timer.expires =3D jiffies + HZ;
 	add_timer(&hose->serr_timer);
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 2a1fe3080712..0dfa2cdc897c 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -755,7 +755,7 @@ static void lanai_shutdown_rx_vci(const struct lanai_vc=
c *lvcc)
 /* Shutdown transmitting on card.
  * Unfortunately the lanai needs us to wait until all the data
  * drains out of the buffer before we can dealloc it, so this
- * can take awhile -- up to 370ms for a full 128KB buffer
+ * can take a while -- up to 370ms for a full 128KB buffer
  * assuming everone else is quiet.  In theory the time is
  * boundless if there's a CBR VCC holding things up.
  */
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 1d33e40d26ea..7318d9800370 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -499,7 +499,7 @@ struct gc_stat {
  * won't automatically reattach).
  *
  * CACHE_SET_STOPPING always gets set first when we're closing down a cach=
e set;
- * we'll continue to run normally for awhile with CACHE_SET_STOPPING set (=
i.e.
+ * we'll continue to run normally for a while with CACHE_SET_STOPPING set =
(i.e.
  * flushing dirty data).
  *
  * CACHE_SET_RUNNING means all cache devices have been registered and jour=
nal
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde1..87b4341cb42c 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -257,7 +257,7 @@ static CLOSURE_CALLBACK(bch_data_insert_start)
=20
 	/*
 	 * But if it's not a writeback write we'd rather just bail out if
-	 * there aren't any buckets ready to write to - it might take awhile and
+	 * there aren't any buckets ready to write to - it might take a while and
 	 * we might be starving btree writes for gc or something.
 	 */
=20
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/eth=
ernet/google/gve/gve_rx_dqo.c
index dcb0545baa50..6a0be54f1c81 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -608,7 +608,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct =
gve_rx_ring *rx,
 	buf_len =3D compl_desc->packet_len;
 	hdr_len =3D compl_desc->header_len;
=20
-	/* Page might have not been used for awhile and was likely last written
+	/* Page might have not been used for a while and was likely last written
 	 * by a different thread.
 	 */
 	if (rx->dqo.page_pool) {
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c73a71ac3c29..0066f15153a7 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7795,7 +7795,7 @@ static int hpsa_wait_for_mode_change_ack(struct ctlr_=
info *h)
 	u32 doorbell_value;
 	unsigned long flags;
=20
-	/* under certain very rare conditions, this can take awhile.
+	/* under certain very rare conditions, this can take a while.
 	 * (e.g.: hot replace a failed 144GB drive in a RAID 5 set right
 	 * as we enter this code.)
 	 */
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_=
neo.c
index e8e13bf056e2..2eb9ff26d6e8 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -1189,7 +1189,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 			/*
 			 * The UART triggered us with a bogus interrupt type.
 			 * It appears the Exar chip, when REALLY bogged down, will throw
-			 * these once and awhile.
+			 * these periodically.
 			 * Its harmless, just ignore it and move on.
 			 */
 			jsm_dbg(INTR, &brd->pci_dev,
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 67fc62a49a76..00f52812dbb0 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -2632,7 +2632,7 @@ static int dlm_pick_recovery_master(struct dlm_ctxt *=
dlm)
 					 dlm_reco_master_ready(dlm),
 					 msecs_to_jiffies(1000));
 		if (!dlm_reco_master_ready(dlm)) {
-			mlog(0, "%s: reco master taking awhile\n",
+			mlog(0, "%s: reco master taking a while\n",
 			     dlm->name);
 			goto again;
 		}
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_m=
ain.c
index bbe252b8916c..6050201851b1 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -606,7 +606,7 @@ static int snd_emu10k1_ecard_init(struct snd_emu10k1 *e=
mu)
 	/* Step 2: Calibrate the ADC and DAC */
 	snd_emu10k1_ecard_write(emu, EC_DACCAL | EC_LEDN | EC_TRIM_CSN);
=20
-	/* Step 3: Wait for awhile;   XXX We can't get away with this
+	/* Step 3: Wait for a while;   XXX We can't get away with this
 	 * under a real operating system; we'll need to block and wait that
 	 * way. */
 	snd_emu10k1_wait(emu, 48000);
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 1bf6e3d652f8..ca4b03317539 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -991,7 +991,7 @@ static snd_pcm_uframes_t snd_emu10k1_capture_pointer(st=
ruct snd_pcm_substream *s
 	if (!epcm->running)
 		return 0;
 	if (epcm->first_ptr) {
-		udelay(50);	/* hack, it takes awhile until capture is started */
+		udelay(50);	/* hack, it takes a while until capture is started */
 		epcm->first_ptr =3D 0;
 	}
 	ptr =3D snd_emu10k1_ptr_read(emu, epcm->capture_idx_reg, 0) & 0x0000ffff;
diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/=
selftests/powerpc/tm/tm-tmspr.c
index dd5ddffa28b7..0d64988ffb40 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -14,7 +14,7 @@
  * (1) create more threads than cpus
  * (2) in each thread:
  * 	(a) set TFIAR and TFHAR a unique value
- * 	(b) loop for awhile, continually checking to see if
+ * 	(b) loop for a while, continually checking to see if
  * 	either register has been corrupted.
  *
  * (3) Loop:
--=20
2.39.5

--b64xojk44rmwat7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhliVoACgkQvP0LAY0m
WPGFEQ/8DbYwNy7U1qf5X+siSkqv8Zb3esOfRNF9i9YUDMZ1GdhK4suKYpWFrOZz
dw7FGbgwwgl1BNsKAmQoG23kglIQuB54tFwWN487hlkk4CvpeBQDHlQ8+0W2riUX
fYawEukQC2kZ7+Abxe2ZOYlJGhJJxbTxbDT2oaKRKN/bh87QXXgTK777Y1eYLJkt
sI7zzKwEsRFpaR2qJaoig54fePOyM50gK+U/MxyMjmoXheCWepLndly0/aZKyvjk
Hypk+7p1f2nHMk39vwjeFc4U6nmUa1tCy7iEEOnQNqUV9Uds3Uy9NDqGI2xY0hit
vh/gidHYpTKPKMJFJVuumVVWIrMrqIGxE6sdCFY7Arv5pERKUhPIh8xVtsaBUpmc
kQwh87srq5PHjvtCrFIcJDSmiJlB132lokYcq0vwHOy8mp6Q7UNSFhEP15zzq75C
xQ1aeR1SOQ3inWywOAkSZjv80iIdbnQsLZPNeSu5G7/BUZMg2Th5Pvz2h+LSEX2G
adcgBklNOUu+hpsZzlphdKsiyMoPsf4Og/W0sBd+1SYBBd8fLmIpChGPVGxiaqyW
+OqGHWqtAJHFtK5o+xZreq0tD/WiMgfkU4rObLg1aEfhSP6ILf8YacYYXuTgnQPb
BHOD8IgLIY1uuG6tB/t5XqoG2JTUxGsxkZZ84kovSpLGkpEdN1A=
=4j77
-----END PGP SIGNATURE-----

--b64xojk44rmwat7t--

