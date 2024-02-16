Return-Path: <linux-kselftest+bounces-4851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52AB857CDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E95283531
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC20126F2E;
	Fri, 16 Feb 2024 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EYWDIS6X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sFnvtkmS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15F266D4;
	Fri, 16 Feb 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087388; cv=none; b=VA/ghxP0RxmXF9ejbbDJAmTlgM0xYtKomYZpYqkyZZGeCi7ZKh+NRX2Cb7U232ISNJ1HQOYaZbrRqrajozue8lkjCU2u1W28R87V7y09i4+rKbt/cGNbq8/esDCPSEV3vYFcLaTxkfBqIdQ6jyCXL3nxhwRbq3HoEz2GCMAARQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087388; c=relaxed/simple;
	bh=LFbSSqlguBhZyI1xwk5Pl9KhUuY44k1PlYM1rVuK++U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WA3bq11IuXkSb+Z9DTpkhLS9RPQEIytkdWC2ZvSsG75I0TmFsIA0EWh/XyiJCe79LYnK8T63RSaC8LAv8K/cBwaOZfbIbRVsPZPsWdD8Pz7JG7a72zIYcS7gxqpdpSOwz5PUUdhIztiwTSkSG9+aAD2JRoh6IAzXI9FexT1dhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EYWDIS6X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sFnvtkmS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5838721FF2;
	Fri, 16 Feb 2024 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708087379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cqlvy/DHQAcWHXEG+Le2aNhMjktrI0RvuODJSfbDi6I=;
	b=EYWDIS6X0P3AvaQDzak4dUskv4WjUPl0DhujxiJyoQYwzmk0USCyWcEcsSuY+u0zX+Vxz1
	H4dmfVlM+t2IsgvViaiIhL7f3qkSLlPLyVF52H7WWHOeIPe1PlNbEdr1YqG38/EU5tEwqA
	hli63kknRAFLorfZLmVo1FeNJBfThh8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708087377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cqlvy/DHQAcWHXEG+Le2aNhMjktrI0RvuODJSfbDi6I=;
	b=sFnvtkmSPCpYIC2DOZnCeG9CSo/P+2wtrEsVpmIaa0/QFhJqwnYt/9fyZ0MjbsNtGEo+ad
	FkAVjTKX5lGwD+LZLErStP5M7BdXiynXevIVGIzXzlofhl5fkPsZmqKPWB2txoD77W7CqF
	cahxEEwGBxnm40ZbY1veMsDjaX6da0o=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CFE4C13343;
	Fri, 16 Feb 2024 12:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Nko6JFBYz2VYIwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Fri, 16 Feb 2024 12:42:56 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 16 Feb 2024 09:42:45 -0300
Subject: [PATCH bpf-next] selftests: bpf: Remove empty TEST_CUSTOM_PROGS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-bpf-selftests-custom-progs-v1-1-f7cf281a1fda@suse.com>
X-B4-Tracking: v=1; b=H4sIAERYz2UC/x3MQQqDMBBA0avIrB2Io5bSqxQXmk50oE1CJoog3
 t3U5Vv8f4ByElZ4VQck3kQl+IKmrsAuo58Z5VMMZKgz1PQ4RYfKX5dZs6JdNYcfxhRmRSLT9e3
 0sPY5QhnExE72e/6Gf+d5zzCc5wXK3Ff1dgAAAA==
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708087374; l=1654;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=LFbSSqlguBhZyI1xwk5Pl9KhUuY44k1PlYM1rVuK++U=;
 b=isp8iI0S41hs8uBiLLql0fxxJu7GKe6d4CfKTC1+nylwLRjV1+y1YAe5hkB8Z2wCrQ+Jp68vj
 NLQoTsKjJVqBK9B1vOLsXV65S9BQwlM+ULxJhy6SbRK6csj68Tg4bKg
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sFnvtkmS
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_RATELIMIT(0.00)[to_ip_from(RLwm53sskssc7cc3rt7fc71wwe)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 FREEMAIL_TO(0.00)[kernel.org,gmail.com,fb.com,iogearbox.net,linux.dev,google.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.81
X-Rspamd-Queue-Id: 5838721FF2
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Commit f04a32b2c5b5 ("selftests/bpf: Do not use sign-file as testcase")
removed the TEST_CUSTOM_PROGS assignment, and removed it from being used
on TEST_GEN_FILES. Remove two leftovers from that cleanup.

Found by inspection.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a38a3001527c..d9029d44b8f2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -197,8 +197,7 @@ endif
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
 # rule for binaries.
 $(notdir $(TEST_GEN_PROGS)						\
-	 $(TEST_GEN_PROGS_EXTENDED)					\
-	 $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
+	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	\
@@ -752,7 +751,7 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
+EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\

---
base-commit: 682158ab532a5bd24399fec25b65fec561f0f6e9
change-id: 20240215-bpf-selftests-custom-progs-220453b6cc8a

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


