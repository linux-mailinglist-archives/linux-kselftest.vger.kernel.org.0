Return-Path: <linux-kselftest+bounces-16640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA296395B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 06:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33178B23005
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 04:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9E8287D;
	Thu, 29 Aug 2024 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbKnHCXo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9E23BF;
	Thu, 29 Aug 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905725; cv=none; b=HWcPTd17zgdaL98+CgpRdfGlnIB7OHKQux1DyWo6QnFFPZSG3pD240oa6ekugHEfbh/B0+ubtTtCH8hSaTuTgXI2/+bDMKt6h0ITW2tZH2FpUMi3aTwhH/wBb1xqE3enT+5b1+j8ubb4E/lOR97i02n1qPBuf/bwiRAurAAOAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905725; c=relaxed/simple;
	bh=LWQtLgZZu8tCfqnqjrIXLUAEDTMm/Ny1scYYBAuCUHI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNz/MQb9xQIJo6HHC+qlLrWT1FCNmtLt93tQoACzqbw+wg6D+ng6jJnAFazsf+h/L3O61rpPje497p/5w4ErU+P7FgBkqLFfDcltoc/9wJOskzrx5l5M4NrsCLtgXkpIbQEz5LPhJlHWe6mwSF/Wcyb0sgnoi6NAc4giYUEOOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbKnHCXo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-204eebfaebdso1842515ad.1;
        Wed, 28 Aug 2024 21:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724905723; x=1725510523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIzkwIMd5hoc+ClzeMKK/i7AA4aktiBj8nauUJkRQ3o=;
        b=PbKnHCXoLLw4Fw8kVRHdz6CBm6LSh6+cpEw2kd/V6k59NyeI4dJN3UBxxo4M5Mcwby
         z6UK62scf++Mhs0HM4MOULGC4P7mzz5PT6UYLIja9KY2Sq7MUHW40aFcfFsP87+FMDGz
         XjmjRreXo4ZLMzMn+k7PoAxYvUQIyuSwVxTPDq796EcyNYxi6z5ZC3XJAtrTTmX6pLEv
         YT+zG25QnF8dta4iyYWM6zqfeBG4nLKcyBNo/fcCf8wJQdGfh4eSyUCb+Ql8SpTS2Jwm
         gNC3DtptjszUGR7kBQbIztKRN2KauWfDeMTt1X+jkIBc1y0Lsu/+OaZXYbctHTGUUNhl
         Zk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724905723; x=1725510523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIzkwIMd5hoc+ClzeMKK/i7AA4aktiBj8nauUJkRQ3o=;
        b=xJ2kGAFGj9uKfgE6g+OSBCy3d/N3bdyNegiYR6oJCrJ6PBaFg+kDDe5Tvwcu6tyava
         NuGK6KbRNy9EoBJC6FBipV87zWyoiXXJKqqxuvjiKUJFJ0NJNOUSEsk7djFtcaz/t/He
         8rupcLEqDku9Lwzg6WW2dC0bHNim9klY6NUc9T43vHGeda2mrVPwrAhvL1tEN7afUPY3
         iMzG3fCaSpvVXHeVVlu5sfmvZu/jtjLBkvuHMWE5rCFXfe85LlltvTqIezq0a4yZP14G
         HwXRRz/plZXhb/Cqbg78Ue4WlAis1LQuMy/+/LhfG+bZ2Z69n9Dd5oiz+qGfla1rI3Us
         ffNw==
X-Gm-Message-State: AOJu0YzuheSZy2SEKcRrqsVsCVerY/sJpVvxongMwzKkf35mCaPrprGk
	nhGPi6thekZoe6zq/e9NdnlrCnzX1m5OLStSvte8UZfIY6gd5P6ZLLQW1H3F
X-Google-Smtp-Source: AGHT+IEWcv+KuDXd0q4goKH7BMEUteeDspjfrKw1zga/q15RQ2Bu7GLN0F0B+W7u0ykFOnL2Clbz6g==
X-Received: by 2002:a17:903:3590:b0:1fb:57e7:5bc6 with SMTP id d9443c01a7336-2050c23dd4emr19833695ad.23.1724905722538;
        Wed, 28 Aug 2024 21:28:42 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155637bfsm2657835ad.294.2024.08.28.21.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 21:28:41 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 28 Aug 2024 21:28:34 -0700
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 0/8] libbpf, selftests/bpf: Support
 cross-endian usage
Message-ID: <Zs/48v0yRjJDUDu0@kodidev-ubuntu>
References: <cover.1724843049.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CiKMM2wF0C80B0Q7"
Content-Disposition: inline
In-Reply-To: <cover.1724843049.git.tony.ambardar@gmail.com>


--CiKMM2wF0C80B0Q7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 04:11:50AM -0700, Tony Ambardar wrote:
> Hello all,

[snip]

> Changelog:
> ---------
> v2 -> v3: (feedback from Andrii)
>  - improve some log and commit message formatting
>  - restructure BTF.ext endianness safety checks and byte-swapping
>  - use BTF.ext info record definitions for swapping, require BTF v1
>  - follow BTF API implementation more closely for BTF.ext
>  - explicitly reject loading non-native endianness program into kernel
>  - simplify linker output byte-order setting
>  - drop redundant safety checks during linking
>  - simplify endianness macro and improve blob setup code for light skel
>  - no unexpected test failures after cross-compiling x86_64 -> s390x

Sadly, shortly after posting v3 I hit a strange new issue in CI testing.

Existing code in bpf_object__elf_finish() doesn't zero Ehdr references
after freeing the related ELF data, allowing use of stale endian data
which can be reallocated and overwritten, leading to rare, confusing CI
errors like:

  test_tailcall_count:PASS:open fentry_obj file 0 nsec
  test_tailcall_count:PASS:find fentry prog 0 nsec
  test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
  libbpf: object 'tailcall_bpf2bp' is not native endianness
  test_tailcall_count:FAIL:load fentry_obj unexpected error: -4003 (errno 4003)
  #333/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL

I have a minor patch to fix this but will wait for feedback on v3 before
posting it together with any further requested changes in a v4. Apologies
for the extra churn, and I'll attach the pending patch for reference.

Thanks,
Tony


--CiKMM2wF0C80B0Q7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="elf-use-after-free.patch"

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -694,6 +694,8 @@ struct bpf_object {
 	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
 	struct elf_state efile;
 
+	unsigned char byteorder;
+
 	struct btf *btf;
 	struct btf_ext *btf_ext;
 
@@ -1521,6 +1523,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
+	obj->efile.ehdr = NULL;
 	obj->efile.symbols = NULL;
 	obj->efile.arena_data = NULL;
 
@@ -1586,6 +1589,18 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		goto errout;
 	}
 
+	/* Validate ELF object endianness... */
+	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
+	    ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
+		err = -LIBBPF_ERRNO__ENDIAN;
+		pr_warn("elf: '%s' has unknown byte order\n", obj->path);
+		goto errout;
+	}
+	/* and preserve outside lifetime of bpf_object_open() */
+	obj->byteorder = ehdr->e_ident[EI_DATA];
+
+
+
 	if (elf_getshdrstrndx(elf, &obj->efile.shstrndx)) {
 		pr_warn("elf: failed to get section names section index for %s: %s\n",
 			obj->path, elf_errmsg(-1));
@@ -1617,9 +1632,9 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 static bool is_native_endianness(struct bpf_object *obj)
 {
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	return obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2LSB;
+	return obj->byteorder == ELFDATA2LSB;
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	return obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2MSB;
+	return obj->byteorder == ELFDATA2MSB;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif

--CiKMM2wF0C80B0Q7--

