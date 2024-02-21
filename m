Return-Path: <linux-kselftest+bounces-5175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D083F85DD00
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584D61F22E6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FA7EEF5;
	Wed, 21 Feb 2024 14:00:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407387EEF0
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524000; cv=none; b=gQeqXPn6jm6Q3OgManMpiz+fV3d3sPHkzQwyR2Lwca28+SMUtuEuJHOKQ/BSenoAzBiS7JDhV1VqUg87F7bXahfExCSmP8cFNj0+7TGimWRPNqDhclIEzAktn5sfGYgMcwxC6tOyAPNvrKgD8VxzcF0deQBrCCrl8Xy53lu/Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524000; c=relaxed/simple;
	bh=2OeP1aRgsHSl4o5ZkmAM6xrCN4HXlOAk3pJkB0LAvy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ipS5kzOP7RiMCLXaaqfVZ+v7d1JrO81oVuYehFO/L5Fz0tJ6pq7CTXL/MBXNLRgPIsiij+/7ADCcAkxJjy5YZ+vJTVH9xV/U3n5LO8INU3SIoRKe6JsAS02ckfdwRAhmy0fvEQ75JhI3vtOJNuBwaS9XzjXUmcUh4zR3yDRBJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-O8-1ApXqN6akXVLrirnvUQ-1; Wed,
 21 Feb 2024 08:59:43 -0500
X-MC-Unique: O8-1ApXqN6akXVLrirnvUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 202B629ABA1C;
	Wed, 21 Feb 2024 13:59:43 +0000 (UTC)
Received: from hog (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CD6448B;
	Wed, 21 Feb 2024 13:59:41 +0000 (UTC)
Date: Wed, 21 Feb 2024 14:59:40 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Vakul Garg <vakul.garg@nxp.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] tls: don't skip over different type records from
 the rx_list
Message-ID: <ZdYBzKcmIorAO47N@hog>
References: <cover.1708007371.git.sd@queasysnail.net>
 <f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
 <20240219120703.219ad3b2@kernel.org>
 <ZdPgAjFobWzrg_qY@hog>
 <20240220175053.16324f4d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240220175053.16324f4d@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-20, 17:50:53 -0800, Jakub Kicinski wrote:
> On Tue, 20 Feb 2024 00:10:58 +0100 Sabrina Dubroca wrote:
> > 2024-02-19, 12:07:03 -0800, Jakub Kicinski wrote:
> > > On Thu, 15 Feb 2024 17:17:31 +0100 Sabrina Dubroca wrote: =20
> > > > @@ -1772,7 +1772,8 @@ static int process_rx_list(struct tls_sw_cont=
ext_rx *ctx,
> > > >  =09=09=09   u8 *control,
> > > >  =09=09=09   size_t skip,
> > > >  =09=09=09   size_t len,
> > > > -=09=09=09   bool is_peek)
> > > > +=09=09=09   bool is_peek,
> > > > +=09=09=09   bool *more)
> > > >  {
> > > >  =09struct sk_buff *skb =3D skb_peek(&ctx->rx_list);
> > > >  =09struct tls_msg *tlm; =20
> > >=20
> > > > @@ -1844,6 +1845,10 @@ static int process_rx_list(struct tls_sw_con=
text_rx *ctx,
> > > > =20
> > > >  out:
> > > >  =09return copied ? : err;
> > > > +more:
> > > > +=09if (more)
> > > > +=09=09*more =3D true;
> > > > +=09goto out; =20
> > >=20
> > > Patches look correct, one small nit here -
> > >=20
> > > I don't have great ideas how to avoid the 7th argument completely but=
  =20
> >=20
> > I hesitated between this patch and a variant combining is_peek and
> > more into a single u8 *flags, but that felt a bit messy (or does that
> > fall into what you describe as "not [having] great ideas"? :))
>=20
> I guess it saves a register, it seems a bit better but then it's a
> truly in/out argument :)

We already do that with darg all over the receive code, so it
shouldn't be too confusing to readers. It can be named flags_inout if
you think that would help, or have a comment like above tls_decrypt_sg.

> > > I think it'd be a little cleaner if we either:
> > >  - passed in err as an output argument (some datagram code does that
> > >    IIRC), then function can always return copied directly, or  =20
> >=20
> > (yes, __skb_wait_for_more_packets, __skb_try_recv_datagram, and their
> > variants)
> >=20
> > >  - passed copied as an output argument, and then we can always return
> > >    err? =20
> >=20
> > Aren't those 2 options adding an 8th argument?
>=20
> No, no, still 7, if we separate copied from err - checking err < 0
> is enough to know that we need to exit.

Right, I realized that you probably meant something like that as I was
going to bed last night.

It's not exactly enough, since tls_record_content_type will return 0
on a content type mismatch. We'll have to translate that into an
"error". I think it would be a bit nicer to set err=3D1 and then check
err !=3D 0 in tls_sw_recvmsg (we can document that in a comment above
process_rx_list) rather than making up a fake errno. See diff [1].

Or we could swap the 0/1 returns from tls_record_content_type and
switch the err <=3D 0 tests to err !=3D 0 after the existing calls, then
process_rx_list doesn't have a weird special case [2].

What do you think?


> Differently put, perhaps, my preference is to pass an existing entity
> (err or copied), rather that conjure new concept (more) on one end and
> interpret it on the other.
>=20
> > I tend to find ">=3D 0 on success, otherwise errno" more readable,
> > probably because that's a very common pattern (either for recvmsg
> > style of cases, or all the ERR_PTR type situations).
>=20
> Right it definitely is a good pattern. I think passing copied via
> argument would give us those semantics still?

For recvmsg sure, but not for process_rx_list.

> > > I like the former a little better because we won't have to special ca=
se
> > > NULL for the "after async decryption" call sites. =20
> >=20
> > We could also pass &rx_more every time and not check for NULL.
> >=20
> > What do you want to clean up more specifically? The number of
> > arguments, the backwards goto, the NULL check before setting *more,
> > something else/all of the above?
>=20
> Not compiled, but what I had in mind was something along the lines of:

copied is a ssize_t (but ret isn't), so the change gets a bit uglier :(


------------ 8< ------------

[1] fix by setting err=3D1 in process_rx_list

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 43dd0d82b6ed..711504614da7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1766,13 +1766,19 @@ static void tls_rx_rec_done(struct tls_sw_context_r=
x *ctx)
  * decrypted records into the buffer provided by caller zero copy is not
  * true. Further, the records are removed from the rx_list if it is not a =
peek
  * case and the record has been consumed completely.
+ *
+ * Return:
+ *  - 0 if len bytes were copied
+ *  - 1 if < len bytes were copied due to a record type mismatch
+ *  - <0 if an error occurred
  */
 static int process_rx_list(struct tls_sw_context_rx *ctx,
 =09=09=09   struct msghdr *msg,
 =09=09=09   u8 *control,
 =09=09=09   size_t skip,
 =09=09=09   size_t len,
-=09=09=09   bool is_peek)
+=09=09=09   bool is_peek,
+=09=09=09   ssize_t *out_copied)
 {
 =09struct sk_buff *skb =3D skb_peek(&ctx->rx_list);
 =09struct tls_msg *tlm;
@@ -1802,8 +1808,11 @@ static int process_rx_list(struct tls_sw_context_rx =
*ctx,
 =09=09tlm =3D tls_msg(skb);
=20
 =09=09err =3D tls_record_content_type(msg, tlm, control);
-=09=09if (err <=3D 0)
+=09=09if (err <=3D 0) {
+=09=09=09if (err =3D=3D 0)
+=09=09=09=09err =3D 1;
 =09=09=09goto out;
+=09=09}
=20
 =09=09err =3D skb_copy_datagram_msg(skb, rxm->offset + skip,
 =09=09=09=09=09    msg, chunk);
@@ -1843,7 +1852,8 @@ static int process_rx_list(struct tls_sw_context_rx *=
ctx,
 =09err =3D 0;
=20
 out:
-=09return copied ? : err;
+=09*out_copied =3D copied;
+=09return err;
 }
=20
 static bool
@@ -1966,11 +1976,10 @@ int tls_sw_recvmsg(struct sock *sk,
 =09=09goto end;
=20
 =09/* Process pending decrypted records. It must be non-zero-copy */
-=09err =3D process_rx_list(ctx, msg, &control, 0, len, is_peek);
-=09if (err < 0)
+=09err =3D process_rx_list(ctx, msg, &control, 0, len, is_peek, &copied);
+=09if (err !=3D 0)
 =09=09goto end;
=20
-=09copied =3D err;
 =09if (len <=3D copied || (copied && control !=3D TLS_RECORD_TYPE_DATA))
 =09=09goto end;
=20
@@ -2114,6 +2123,7 @@ int tls_sw_recvmsg(struct sock *sk,
=20
 recv_end:
 =09if (async) {
+=09=09ssize_t ret2;
 =09=09int ret;
=20
 =09=09/* Wait for all previously submitted records to be decrypted */
@@ -2130,10 +2140,10 @@ int tls_sw_recvmsg(struct sock *sk,
 =09=09/* Drain records from the rx_list & copy if required */
 =09=09if (is_peek || is_kvec)
 =09=09=09err =3D process_rx_list(ctx, msg, &control, copied,
-=09=09=09=09=09      decrypted, is_peek);
+=09=09=09=09=09      decrypted, is_peek, &ret2);
 =09=09else
 =09=09=09err =3D process_rx_list(ctx, msg, &control, 0,
-=09=09=09=09=09      async_copy_bytes, is_peek);
+=09=09=09=09=09      async_copy_bytes, is_peek, &ret2);
 =09}
=20
 =09copied +=3D decrypted;


------------ 8< ------------

[2] fixing the bug by changing tls_record_content_type as well

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 43dd0d82b6ed..3da62ba97945 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1734,6 +1734,11 @@ int decrypt_skb(struct sock *sk, struct scatterlist =
*sgout)
 =09return tls_decrypt_sg(sk, NULL, sgout, &darg);
 }
=20
+/* Return:
+ *  - 0 on success
+ *  - 1 if the record's type doesn't match the value in control
+ *  - <0 if an error occurred
+ */
 static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm=
,
 =09=09=09=09   u8 *control)
 {
@@ -1751,10 +1756,10 @@ static int tls_record_content_type(struct msghdr *m=
sg, struct tls_msg *tlm,
 =09=09=09=09return -EIO;
 =09=09}
 =09} else if (*control !=3D tlm->control) {
-=09=09return 0;
+=09=09return 1;
 =09}
=20
-=09return 1;
+=09return 0;
 }
=20
 static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
@@ -1766,13 +1771,19 @@ static void tls_rx_rec_done(struct tls_sw_context_r=
x *ctx)
  * decrypted records into the buffer provided by caller zero copy is not
  * true. Further, the records are removed from the rx_list if it is not a =
peek
  * case and the record has been consumed completely.
+ *
+ * Return:
+ *  - 0 if len bytes were copied
+ *  - 1 if < len bytes were copied due to a record type mismatch
+ *  - <0 if an error occurred
  */
 static int process_rx_list(struct tls_sw_context_rx *ctx,
 =09=09=09   struct msghdr *msg,
 =09=09=09   u8 *control,
 =09=09=09   size_t skip,
 =09=09=09   size_t len,
-=09=09=09   bool is_peek)
+=09=09=09   bool is_peek,
+=09=09=09   ssize_t *out_copied)
 {
 =09struct sk_buff *skb =3D skb_peek(&ctx->rx_list);
 =09struct tls_msg *tlm;
@@ -1784,7 +1795,7 @@ static int process_rx_list(struct tls_sw_context_rx *=
ctx,
 =09=09tlm =3D tls_msg(skb);
=20
 =09=09err =3D tls_record_content_type(msg, tlm, control);
-=09=09if (err <=3D 0)
+=09=09if (err !=3D 0)
 =09=09=09goto out;
=20
 =09=09if (skip < rxm->full_len)
@@ -1802,7 +1813,7 @@ static int process_rx_list(struct tls_sw_context_rx *=
ctx,
 =09=09tlm =3D tls_msg(skb);
=20
 =09=09err =3D tls_record_content_type(msg, tlm, control);
-=09=09if (err <=3D 0)
+=09=09if (err !=3D 0)
 =09=09=09goto out;
=20
 =09=09err =3D skb_copy_datagram_msg(skb, rxm->offset + skip,
@@ -1843,7 +1854,8 @@ static int process_rx_list(struct tls_sw_context_rx *=
ctx,
 =09err =3D 0;
=20
 out:
-=09return copied ? : err;
+=09*out_copied =3D copied;
+=09return err;
 }
=20
 static bool
@@ -1966,11 +1978,10 @@ int tls_sw_recvmsg(struct sock *sk,
 =09=09goto end;
=20
 =09/* Process pending decrypted records. It must be non-zero-copy */
-=09err =3D process_rx_list(ctx, msg, &control, 0, len, is_peek);
-=09if (err < 0)
+=09err =3D process_rx_list(ctx, msg, &control, 0, len, is_peek, &copied);
+=09if (err !=3D 0)
 =09=09goto end;
=20
-=09copied =3D err;
 =09if (len <=3D copied || (copied && control !=3D TLS_RECORD_TYPE_DATA))
 =09=09goto end;
=20
@@ -2032,7 +2043,7 @@ int tls_sw_recvmsg(struct sock *sk,
 =09=09 * For tls1.3, we disable async.
 =09=09 */
 =09=09err =3D tls_record_content_type(msg, tls_msg(darg.skb), &control);
-=09=09if (err <=3D 0) {
+=09=09if (err !=3D 0) {
 =09=09=09DEBUG_NET_WARN_ON_ONCE(darg.zc);
 =09=09=09tls_rx_rec_done(ctx);
 put_on_rx_list_err:
@@ -2114,6 +2125,7 @@ int tls_sw_recvmsg(struct sock *sk,
=20
 recv_end:
 =09if (async) {
+=09=09ssize_t ret2;
 =09=09int ret;
=20
 =09=09/* Wait for all previously submitted records to be decrypted */
@@ -2130,10 +2142,10 @@ int tls_sw_recvmsg(struct sock *sk,
 =09=09/* Drain records from the rx_list & copy if required */
 =09=09if (is_peek || is_kvec)
 =09=09=09err =3D process_rx_list(ctx, msg, &control, copied,
-=09=09=09=09=09      decrypted, is_peek);
+=09=09=09=09=09      decrypted, is_peek, &ret2);
 =09=09else
 =09=09=09err =3D process_rx_list(ctx, msg, &control, 0,
-=09=09=09=09=09      async_copy_bytes, is_peek);
+=09=09=09=09=09      async_copy_bytes, is_peek, &ret2);
 =09}
=20
 =09copied +=3D decrypted;

--=20
Sabrina


