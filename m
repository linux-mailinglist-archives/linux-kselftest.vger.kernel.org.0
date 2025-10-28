Return-Path: <linux-kselftest+bounces-44170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34098C12ACB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C733134D19C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FE270540;
	Tue, 28 Oct 2025 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJdyMseN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353026FA5B
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619085; cv=none; b=SZcNGOEaaRwa5ytEh7yV/PDJCS0y1akD3pAKqTLP+YSb94Byn8tj3FBvDIgqqwltDePEZirTRUcwHKD1JkgG9r+/xG7U8aB8gLB970taYK6zsjkIXKArz0MyLwCG2cqFLwwuJVczd0rOCa2fprRQuWXxiVpKYs/TuAaNMJfukx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619085; c=relaxed/simple;
	bh=+NfucJFORP/00mVrD00XoHgUbFhguqmwyUOVKEDS8dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VS6G8OyHidndXFVgHW0+GmeQjGEzNSlbLQgMb0ZctBszFmr9yKTD3oBTYrzNfBPRoFgkK5TAaPJBSAQKKG0lm3QewJDUJT3bPM+sJGFmMkmw4HivzArqmQtC01UvGuDpASYEg+huZb3opI1iNTo41y3+m41wtGEbU1duKiakZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJdyMseN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2909e6471a9so36198795ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 19:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761619083; x=1762223883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgiyVtmXhmeHrPHy6vJ+jCIaxcozejU0dTrutqnOA6s=;
        b=sJdyMseNa8/gDsAUNMpAkjhbTOj2xf/YvS7khcFX0jmUayDvdKiDISD1VfRPziivQg
         iOwWJ3X2K0zo2Q8CMcsMve1OXWEcSxcr51f05ADnB63WE04kkeHsgnTAJ4B985rCismv
         B/gDinuk+KleKL6e0df5qtu2IxFjnN7VKJcqPe1dLYbB+XB9Mvd7wquEpXulDKJxxXUr
         VUJ13wF9HLM5FagumtHS1khJ67QeYYcfOpMUqwMcmbEzobEkF2OE9ZJJbVy8Bcs/YDBS
         GiApA/PTD2S8jv1tQRKskDDdOL8rI15zbGVZ3/XZyil6+ClGBRDBDvVfqHKc0BxLzC6F
         CgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761619083; x=1762223883;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgiyVtmXhmeHrPHy6vJ+jCIaxcozejU0dTrutqnOA6s=;
        b=w2Z8BcQVDqj1kS6wzQavg0RY9RN26DmIVKj+Ji2VmkRFEelCppNvmxjH0hi08auY7q
         cWfG1cZP5QEG5k4zF2QTNsk+QPKHoAMzLy83gx530MaDSOJ8W0WiOe8QsGk0Hp6mPAo1
         ZfRhGdF/shK3J8kCaKAsR0ylOuaXDIL4FJeRRSgnFpi0WumzUvdtf7tOZAqBU0jNH4R9
         1PDNvNX5hzpHYdICeBq15vIhs01CPzRcMWTWD3f7dPJlWBoYcsGxk5yio3PBiR3lBEQj
         ckUDACaKgY+pd8vUNKK7ZJ5N4t8R38KAMJWXlLDNDUsus5Pgd3nSAzqVpaAp1fvUXhEo
         AO5w==
X-Forwarded-Encrypted: i=1; AJvYcCUeFlPPR5LLP1TY9VBbxZexwijCd91Fa0GZrf7fkRU9W06jvgSh5g6W9sNCDccjacEhev8BLlLZSYDNsjssNH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFZ0ZkU0ggcM0E7ZrRJ4IZl6HCBHAbwCXcGCnDlF5ylGyZKsl
	LoAlr4uB3Tl204++I6B0E8ulAIocehi063Lem/8DbB4EnsS/MKfP8dO4CpmOoTmRbovebbIe8v4
	hoTO4VQ==
X-Google-Smtp-Source: AGHT+IEzk/xGx0XyC0NesVSpClX0jev6Dk0Hu9e/ap0h2Zy3h5HU8NNT6Jgrmsc7DRydLO5XwDXkLbfrm9s=
X-Received: from pjbbh20.prod.google.com ([2002:a17:90b:494:b0:327:50fa:eff9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:245:b0:269:603f:420a
 with SMTP id d9443c01a7336-294cb35ec37mr20510495ad.5.1761619083284; Mon, 27
 Oct 2025 19:38:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 02:37:48 +0000
In-Reply-To: <aQAjgRwd8P+YZSa6@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aQAjgRwd8P+YZSa6@rli9-mobl>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028023801.2024155-1-kuniyu@google.com>
Subject: Re: [PATCH] selftests: harness: Support KCOV.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: lkp@intel.com
Cc: kuniyu@google.com, linux-kselftest@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: kernel test robot <lkp@intel.com>
Date: Tue, 28 Oct 2025 09:59:29 +0800
> Hi Kuniyuki,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on shuah-kselftest/next]
> [also build test WARNING on shuah-kselftest/fixes kees/for-next/seccomp l=
inus/master v6.18-rc2 next-20251024]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
selftests-harness-Support-KCOV/20251017-164507
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kself=
test.git next
> patch link:    https://lore.kernel.org/r/20251017084022.3721950-1-kuniyu%=
40google.com
> patch subject: [PATCH] selftests: harness: Support KCOV.
> :::::: branch date: 9 days ago
> :::::: commit date: 9 days ago
> config: x86_64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/2=
0251026/202510262116.jwyrgplV-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251026/202510262116.jwyrgplV-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202510262116.jwyrgplV-lkp@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from listmount_test.c:14:
>    ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(s=
truct __test_metadata *, struct __fixture_variant_metadata *, char *)' from=
 incompatible pointer type 'void (*)(struct __test_metadata *, struct __fix=
ture_variant_metadata *)' [-Wincompatible-pointer-types]
>      188 |                   .fn =3D &wrapper_##test_name, \
>          |                         ^
>    ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_=
IMPL'
>      157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
>          |                         ^~~~~~~~~~~
>    listmount_test.c:23:1: note: in expansion of macro 'TEST'
>       23 | TEST(listmount_forward)
>          | ^~~~

Oh sorry, I missed TEST() as af_unix didn't use it,
but I should've compiled all tests.

Will squash this diff to v2.

Thanks!

---8<---
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/se=
lftests/kselftest_harness.h
index cba8020853b5..5b7a01722981 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -179,9 +179,12 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
-		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
+		struct __fixture_variant_metadata __attribute__((unused)) *variant, \
+		char *test_full_name) \
 	{ \
+		enable_kcov(_metadata); \
 		test_name(_metadata); \
+		disable_kcov(_metadata, test_full_name); \
 	} \
 	static struct __test_metadata _##test_name##_object =3D \
 		{ .name =3D #test_name, \
---8<---

