Return-Path: <linux-kselftest+bounces-9548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D728BD47B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578292830ED
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FCF1586D7;
	Mon,  6 May 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnloiKQk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F414293
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019606; cv=none; b=d7FdlayPUNHOfdA4ZMMUKX09A7qtUnKLP6T+h4BDs4Kny7vaDTEsRCeDuFFqKGfQETpk9sJAS4OqH2/o3XyGBpL/+lX6KHtDeVZ/NFK3zam7vb2p9ERCFIvEvVWDU3gZHNV+L9ZHr4fH6E+7uDEXitjtj2Jrg5DqbZUhfbnFvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019606; c=relaxed/simple;
	bh=29kh0OQhNn8m2tDtlHwrVE2HKUPGcD9TJf7JFu5B20I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ALm71xZRfM99RPIQqNZHcglLYtWiv32Tsx0lMarRvlKu89FWXBztfYTxWYk/qjs0G98RUxYmmlzvXVxINzwcae88wFDbXcN8ErGXU4YDMMc1MPTfETMCoSrVuxzp6/uYdUd2KzV9CGlNBx3uKMmhs9m2AMiUUXpFNkvM5jWrzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnloiKQk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee42b9a13cso6522485ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715019604; x=1715624404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PEorNdErbbliX1pJbW2p9S8u6EaFLwcWfv6R20jo+hk=;
        b=EnloiKQkrAMLAaIGOX9w6DVdy1Ispn4i4n+MmsnZrH9V/ISGVplEricaolBTHuWeCF
         hJ+xkfA0lVk6oyBbWfIAK8gjoRPJzbW2fZNK9CTlM9+UcIXtPmNVNXwD13aephdFYhmx
         uccbHq8j8aehU6SmyT9m3OXp+7Dxtp36zUG1v0W/Zb08/erNtqRCza5Ug8tCPYvrEiKi
         dZge/b8zmrTEcZyCZd0y8R0AoBN3sErpbFEe2VMWYOKTy08OSkyUpFZtQ1KWxnTlf/bA
         zMLWO5wZsXruN9v9c+YJOyANDPmqlNofNJ/nI3yxWjy/xiGZDCtqR5WkEVVkslTmNqDR
         Lhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715019604; x=1715624404;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEorNdErbbliX1pJbW2p9S8u6EaFLwcWfv6R20jo+hk=;
        b=WRJFbCXvOi+r7wxDmnnhTjXkLxJBMRHFrUrHPgmN663wDhz4Ban75gxp2974LSxpwu
         LV483yXaN7KusJBjTNkgiCadHo606enYQBvR9Ing8KxHVUuhmdmfGdvnmH0zFon/pMEt
         5pkrNgYEm/hJLTTDgyeElunJ8Uicl5JflC+wT8D9VP3DRTC8Ai00Km2CukxP/h+YpSQY
         bovUy0wD/uv3plMzoqmgC1f1qbEZRbnW9/Yeifq58sU8uDHR0AXXD1z0rHZRTCaFvOKS
         Suhwtk4Y/UGVkhhtwmgfEgu5wrWxacb2H1u3VQCRisAf9ue1yq/6D9hdjUUrssnle+LM
         Y2Ow==
X-Gm-Message-State: AOJu0Yy4E0BS3ueXBT9POSXFvh9XKrtHj3c2E+w/IcdKVSLuli/A+AKD
	GepsCrCWlHWfxMvcOOpzX/DuI3HCpdyHd8hBxicRPXXY34w9uqLnMd1BwiUL6Tn94Fti73YF1+4
	QgQ==
X-Google-Smtp-Source: AGHT+IESrbjMUY8Mv1UKtz5WxeKTzz99i+OpRkFhriDD5+V9JAcwp6S8JYlh7Y55BwCk8V/xyJtIzeIlI/M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ec89:b0:1e8:d158:4e13 with SMTP id
 x9-20020a170902ec8900b001e8d1584e13mr796623plg.7.1715019604185; Mon, 06 May
 2024 11:20:04 -0700 (PDT)
Date: Mon,  6 May 2024 18:19:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506181951.1804451-1-edliaw@google.com>
Subject: [PATCH v4] selftests/vDSO: change elf_hash parameter to signed char
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@mit.edu>, "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compilation warnings by changing elf_hash's parameter type
to char * and casting to unsigned char * inside elf_hash:

parse_vdso.c:206:22: warning: passing 'const char *' to parameter of
 type 'const unsigned char *' converts between pointers to integer types
 where one is of the unique plain 'char' type and the other is not
 [-Wpointer-sign]
        ver_hash = elf_hash(version);
                            ^~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)
                                                   ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of
 type 'const unsigned char *' converts between pointers to integer types
 where one is of the unique plain 'char' type and the other is not
 [-Wpointer-sign]
        ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
                                                    ^~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: updated commit message with correct compiler warning
v3: fixed checkpatch errors and indentation
https://lore.kernel.org/all/20240501180622.1676340-1-edliaw@google.com/
v4: moved the typecast into elf_hash based on libelf
https://sourceforge.net/p/elftoolchain/code/HEAD/tree/trunk/libelf/elf_hash.c#l47
---
 tools/testing/selftests/vDSO/parse_vdso.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..33db8abd7d59 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -56,12 +56,15 @@ static struct vdso_info
 } vdso_info;

 /* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *s;
+
+	s = (const unsigned char *) name;
+	while (*s)
 	{
-		h = (h << 4) + *name++;
+		h = (h << 4) + *s++;
 		if (g = h & 0xf0000000)
 			h ^= g >> 24;
 		h &= ~g;
--
2.45.0.rc1.225.g2a3ae87e7f-goog


