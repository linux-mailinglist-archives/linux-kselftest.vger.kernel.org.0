Return-Path: <linux-kselftest+bounces-42759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68ABB8EB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552F44A16AC
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835621A420;
	Sat,  4 Oct 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VTYZRikn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F923CB;
	Sat,  4 Oct 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587848; cv=none; b=FZtMqdqeP75iKWdO1DkH2s6CGAw0I3AwgYUN9Zxsjr/bphRq/eQ8DvkTWnlCqX5jssVtOMQThBp7E9rUZpw1cQ5scDO61l6jHETGgZyZUwPOZXjDQAODTCBKjSJlXjHc/iWPS5DMahrwUXqQtxh+H6yN4eajrBBkAzzmeb6D6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587848; c=relaxed/simple;
	bh=4+YQxF6Yyc1qXtgVJuJFdGLf98O+4LvnwmYl2kYaVqQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=e0U0g22HeEEcQldaoeSykiL6OUP4NVkVXpwxTDE+Ww++v9Y/XA4fJeKbMfiDi7x/padmigcmqyxV77PF9PSs9m2BGdGqP7AeBwtWY9lamMb+8VeTrcaC3HDKzPZcyHUBQVYapOeDeKVKhvWvQe5bht0dy3ijK9PwBh8xLFt1xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VTYZRikn; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759587839;
	bh=qeV31WK13cjvz6ZRDqN9endiddVqQ/kjv9Yxi6CDY5Q=;
	h=From:To:Cc:Subject:Date;
	b=VTYZRiknXBVg4yooD+mCdzWX3NChqfj1LlVHLdP9+yyPbb2UlTMZ9kvPU2u6WA0Lq
	 iOiNhVNiebCPKsDHC1TI3C/5rnsdirR09ltYOy/XvXueOHx2a9O68uR4f11ycAY1Cc
	 8FIut4RfZGvyzB+TT/wOJWI7lhzrMdAvO9utTPuQ=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 5EC3BCB8; Sat, 04 Oct 2025 22:23:44 +0800
X-QQ-mid: xmsmtpt1759587824tx35rnprp
Message-ID: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Nollo+Kiye9TdhQSym4B0s+hcbxKm8a2p/mMhbBb+s8jB31bFjkI
	 ho3wMSVBBn9o4LV1T8RHItO7tZRnOQI9SfVcA2F1Zj9o5Ed8KF97g60wFzNebfp82KeJTz8/2iv+
	 DSEWN+bEVP7ykds9aKw8g2MStMdtsoLiyh5yWNVOojXZG4UlIeEsBlJ8G2tsypfWDo43p0FLBWR3
	 N61rIkxKyq3Dc7NUVpeOn7ieR6dZ2TJlkq8amUNPk2K/rY3PscTHFjgfEg4EZBeFRrpqb9vUUZW1
	 UUkPVodDxt5GVUhwkK981oNj7lYii0yjdNPRyit3tSwjlBvRiYcw5ETU1TurtyDODEn7v/ckuOZ/
	 ZH8j2yporc4ZN1jVk+aGb4ypegnp7h0Ju9HOw3305C7jWPQwWBRNZIRCnQ71UhMEe5WxofQ40MIm
	 RhgdXsYmziK/yy1pwONhOZRJAMJ4+7IfrNRQ183gk+gblh1dKIz3ID9HLO9YGpJU81bXMayRZpk1
	 ozPu8ahR9Ovwi4jGZXK6jhUR8/rJToyTqqdEzv/xHq7MQu1jU+QYqG0PCQbFYkORgyaVinqJBOmC
	 M+Fd5K7v5jA3AikDWUDOawRdHwtyIXRpnQJv/HYUZ8vRwXSodEKSpCvHlLM9zqz95oXpYx36pZA/
	 Et4vEDMV7FJRqRjmyhdDy5MmCLdvBs6YWQlXlp3ruM7LkLcZV2/dcU3aLMdI6EVEqN1UmctLG6oA
	 3qRyhktHtIOtKDBIYryrD3Hmg9dA2ENXfWwuUgxeHUAgvKLnQUb0s5EvAsz7zWYxgbhaQNNgx44N
	 SFUqIwXZmYGjtVNvrgcKdcWo50uLUCnwDvRC7VeGd22OWQSO+TfqB4XxlhheeZFCGdqbB91KX+zK
	 517l/8vvS27wGQTjSaPsWMBij7LYVhcjJDzQ3icakTa4LwOug9xfh6cOPKVvbpuot3mv/4oON9rU
	 heHWqG3w6t07CD+jHSkaMkH3T9QMS8WRih6f2iEILJkBpoyxuViGQtAN5y/eByNhryxwDA9BeYQb
	 PWc9cU0ahI5/MmCcJzQ3IFDbuM6MGf5GYoKk9ouw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next] bpf_doc: Support 1st const parameter of bpf_d_path()
Date: Sat,  4 Oct 2025 22:23:29 +0800
X-OQ-MSGID: <20251004142334.209116-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Since commit 1b8abbb12128 ("bpf...d_path(): constify path argument"),
the first parameter of the bpf_d_path() has been changed to a const
constant. We need to modify the header file and bpf_doc.py.

The two error messages are as follows:

    linux/tools/testing/selftests/bpf$ make

      CLNG-BPF [test_progs] bpf_iter_task_vmas.bpf.o
    progs/bpf_iter_task_vmas.c:52:14: error: passing 'const struct path *'
    to parameter of type 'struct path *' discards qualifiers
    [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
       52 |                 bpf_d_path(&file->f_path, d_path_buf, D_PATH_BUF_SIZE);
          |                            ^~~~~~~~~~~~~
    1 error generated.
    ....
    progs/verifier_vfs_accept.c:80:7: error: assigning to 'struct path *'
    from 'const struct path *' discards qualifiers
    [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
       80 |         path = &file->f_path;
          |              ^ ~~~~~~~~~~~~~
    1 error generated.

Fixes: 1b8abbb12128 ("bpf...d_path(): constify path argument")
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 include/uapi/linux/bpf.h                                | 2 +-
 scripts/bpf_doc.py                                      | 1 +
 tools/include/uapi/linux/bpf.h                          | 2 +-
 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ae83d8649ef1..6829936d33f5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4891,7 +4891,7 @@ union bpf_attr {
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
  *
- * long bpf_d_path(struct path *path, char *buf, u32 sz)
+ * long bpf_d_path(const struct path *path, char *buf, u32 sz)
  *	Description
  *		Return full path for given **struct path** object, which
  *		needs to be the kernel BTF *path* object. The path is
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index c77dc40f7689..15d113a1bc1d 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -788,6 +788,7 @@ class PrinterHelpersHeader(Printer):
             'struct task_struct',
             'struct cgroup',
             'struct path',
+            'const struct path',
             'struct btf_ptr',
             'struct inode',
             'struct socket',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ae83d8649ef1..6829936d33f5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4891,7 +4891,7 @@ union bpf_attr {
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
  *
- * long bpf_d_path(struct path *path, char *buf, u32 sz)
+ * long bpf_d_path(const struct path *path, char *buf, u32 sz)
  *	Description
  *		Return full path for given **struct path** object, which
  *		needs to be the kernel BTF *path* object. The path is
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 3e2d76ee8050..55398c04290a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -70,7 +70,7 @@ __success
 int BPF_PROG(path_d_path_from_file_argument, struct file *file)
 {
 	int ret;
-	struct path *path;
+	const struct path *path;
 
 	/* The f_path member is a path which is embedded directly within a
 	 * file. Therefore, a pointer to such embedded members are still
-- 
2.51.0


