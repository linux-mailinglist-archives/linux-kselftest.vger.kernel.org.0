Return-Path: <linux-kselftest+bounces-32427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E922AA9BAD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF2B7A91C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF726FA7B;
	Mon,  5 May 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Pw6op1kV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7F26D4CD
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470385; cv=none; b=cVFCWdKaPK/teqZrZVFD6Wq+lZGxP+8mLjy6MALkxvVYAzABmmXTCTzOLSH/S7CHN+6536fL5TQ7sslPnPFETD0alwr7DCvz9sSDkTVunckwuNh1SvYp2FIlxbHmvFC96ODJ9eztICMUBYuijOe24EV++AimLbY9kyLrskxraWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470385; c=relaxed/simple;
	bh=ZClhDwB5pKTOs2/ZgKiqPI5f9N+Z5HIqj+FZtgA9DiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UaMr3PpCSmQoVeiRao87qqnV3scbiDQWLnhNURlkvlRf+WvqMc6vRPmNbiEHGmbW2xKQy0QsOMjPwyVLEgwBB8t89PWc+0HSNnME5Xt1Gg4035/jnb8kW/2YhlhJ57uTEQ0DL0MjeJojkjdwgaMnhSVy0jCpFZprVJh48PV4xRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Pw6op1kV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so4560124f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746470381; x=1747075181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRFMs6tsARxEnBbmhIs7BbWLHMkMmA06v2O0FY8OvzE=;
        b=Pw6op1kV2XvmGZ2CtyJAhTuDnhbYOhJgX9LsTlZoNtM+k/mcewNs17ywS5+U9MxLZb
         nexq0UP/jHUjRgwtXx0tr5VsK8hPp53njSQRJNlnD3s+qnTJqEfJ4zzAoPlLQMzUZNcV
         jIUIEhfE+xe7LwwkyN0mMXFHz+roSSzir72nvuQorU2vOuqXDAHwXiXbcezzkq6/vfSh
         LAkWJ6C3AXASplBwHo0yeIR0uJxHh/g2a1V2WShS9dijBY7pr7LY5Q6DOdi+upFz39D4
         68dFho3ebUD8NQHow1LHAS+79LCUIcNQ3ESEYRTnjOkgKWc9wyolOisOH1yZY0j3Dp4G
         SyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470381; x=1747075181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRFMs6tsARxEnBbmhIs7BbWLHMkMmA06v2O0FY8OvzE=;
        b=H8lpeZcEn7X6oVkvFjjE79Vx0cQaXbByErEKxmcN1j7GTgy/Ir1wMQxVPSaNtiHtqU
         OQgEaxBTwJgcL2x1jgnc7Pg+bfj+AoU8zDWeOaYzA/KILp+qcd5rCYN3/KJ4X3Uylbf/
         57A+rShgO2BKusBcshZVcLJkrG6N6X4UpU/HaCx+bw91GKiSozsaeRq4Eb3GNCnetSkG
         QSW3v+CxYeDDBsOJ7hrfmsIzqGUKmX+CWd2Me1ENTI/R3dUrWu1woS2AOuQadrFqmggb
         GZ5n3ti1vBfbbexQwKyt8ohuqo0YPQDOVpC3vGoQynE1W6mOf2dVNNxqrfu1AbuloNgM
         L6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAnQ5mjNCkTzozLy69RhnW93WLtpMT7NCqPpz3iZ0metnyW1vukqgYncFEnExBO3wku16anVFNbXpwgl7fUqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwWmdVF0C33M+mVylG0Tucd/LCnu1zLCy/Z4LItA6oMkJD3+v
	WBTcuDEJMQaSz5JG4RHMfQiQH/+tjnqJXn4dEQbUU0LymmBIgM76Je1pjP1gBYU=
X-Gm-Gg: ASbGncv4S0vWQiVjWNXSzML5MO+LlyiQEZB750Xs+wbq+N1dzacLj4TWJwdJFX+DFki
	1qnjt2mB6xpauRVQ7cYYdURyy/QXDNrh7Gbja4g4M+lFrXPQ5qW/owyo5KWttcL86bJEWB5bcp3
	gmvAJUA+i2KmnGvm+p4IC3vZmdYJNX/MSTIhkt2hV8iyVpXYYPZNun9Sguxp+JRzXX7rnrbiiJf
	oNOEowMLNZHXIuXZNegyFCcEiP4nfI60oI2gxzsuOMM4dG7d4RUJIru5zNl4Vu4RRySAhFc6CM2
	RIHB64lAD3mzFWHcbOxb04/Hm/MsNhtwMTxDAHBM7GqjnV7CHh2j8xAw1+BUxJBaHLEyFBswald
	P2jq/sc+SSOnROWHlb7zLIQMULc14vyaF55Vj
X-Google-Smtp-Source: AGHT+IETFDMIX2vSVQRWaZR0sw5Q/4vDACHJukED/hYw/JW8aw+9tSZ25bM1BT52bl+76K67jrDsNQ==
X-Received: by 2002:a05:6000:2204:b0:39c:2665:2c13 with SMTP id ffacd0b85a97d-3a0ac3eb32cmr60486f8f.54.1746470380849;
        Mon, 05 May 2025 11:39:40 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm11328877f8f.56.2025.05.05.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:39:40 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 05 May 2025 19:38:43 +0100
Subject: [PATCH bpf-next v3 1/3] btf: allow mmap of vmlinux btf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vmlinux-mmap-v3-1-5d53afa060e8@isovalent.com>
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
In-Reply-To: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

User space needs access to kernel BTF for many modern features of BPF.
Right now each process needs to read the BTF blob either in pieces or
as a whole. Allow mmaping the sysfs file so that processes can directly
access the memory allocated for it in the kernel.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/bpf/sysfs_btf.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 58a635a6d5bdf0c53c267c2a3d21a5ed8678ce73..1750390735fac7637cc4d2fa05f96cb2a36aa448 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -667,10 +667,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
  */
 #ifdef CONFIG_DEBUG_INFO_BTF
 #define BTF								\
+	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
 		BOUNDED_SECTION_BY(.BTF, _BTF)				\
 	}								\
-	. = ALIGN(4);							\
+	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
 	}
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 81d6cf90584a7157929c50f62a5c6862e7a3d081..37278d7f38ae72f2d7efcfa859e86aaf12e39a25 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -7,14 +7,51 @@
 #include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/sysfs.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/btf.h>
 
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
+static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  struct vm_area_struct *vma)
+{
+	unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
+	size_t vm_size = vma->vm_end - vma->vm_start;
+	unsigned long addr = (unsigned long)attr->private;
+	int i, err = 0;
+
+	if (addr != (unsigned long)__start_BTF || !PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	if (vma->vm_pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
+		return -EACCES;
+
+	if (vm_size >> PAGE_SHIFT > pages)
+		return -EINVAL;
+
+	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
+
+	for (i = 0; i < pages && !err; i++, addr += PAGE_SIZE)
+		err = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
+				     virt_to_page(addr));
+
+	if (err)
+		zap_vma_pages(vma);
+
+	return err;
+}
+
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
 	.read_new = sysfs_bin_attr_simple_read,
+	.mmap = btf_sysfs_vmlinux_mmap,
 };
 
 struct kobject *btf_kobj;

-- 
2.49.0


