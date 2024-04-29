Return-Path: <linux-kselftest+bounces-9075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F58B63B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 22:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390A4283B42
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B06817798C;
	Mon, 29 Apr 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a76IcWjO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E62176FD6
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422897; cv=none; b=gV784rs5Sp28tcoiwS2oiJ5acSxVvjF6l2HFSuVbwbVDRhw+9Q0GjTDoWPaNznOxobb+VKgeXw3YfrYPNAB/tIW1vlENFUmxNYdgT3bxXQm4uCG+oDpNn5mjn/+R/FBBwhe3GDkx6QNXHt+8AUAm/cy62eFhkLn9nJ7kfh+eRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422897; c=relaxed/simple;
	bh=FJgJcexbKP8Vs2qsQoifsZ/CG9oPAv6wyYJlV8ROmx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=axMBclUFESczgDrmZPKY2vyLUTE15t3ZdnUFkEaH9XV85nrxPqdt3r+Ja00DKcMCMH1bhx5zFGQsOik75pjtG4tfU5EqZnviYbQyRZGRerV5CM14stosT1M7cR8A/Uzlq8PMLEmYxWv7hHHjreFc0wRmpCG2QdSomXcJlMnOjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a76IcWjO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab00d8a2eso83603637b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714422895; x=1715027695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9mL2eooEb/7s/U1rMU577fBDSrTqCDNk48ffx+zYIGY=;
        b=a76IcWjOGXC13WnMKEt6QWBFJVUv5JakGEEpKzAc7w5cChB/v50B6P+HJ/Yo1NLsSW
         J/Eioa6LuliTnWzGFeQbVqV4I/aNtv+pr9R1bHr420Cpkhi7YxTTBi+bA6hp213CgDW+
         4ICZoaCxnBdO0/09cPK6FcbSQNU8XxjCvHeCwb/Ca+fZsjeHF+z+JIkFEmi7GP71qSaK
         RB3V6eVsisA6Ha4vV2y/QaB86wom6qvMeXhdZ0/ysGdHR1gPOHfFDmBVJ+HjpAZAsfZs
         xoGsEhiCeb9PFatTXclb8Djtz0QtT5Gki6ZAWMIlrbPW2Dd8Ze+k8hjnw56NzSfmimHS
         sohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422895; x=1715027695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mL2eooEb/7s/U1rMU577fBDSrTqCDNk48ffx+zYIGY=;
        b=ZkvkFo2laBaCy2KhU4kLKChat55Z6HMPnexYp4BbBYDmN291+JabXv/mdSyacz8pll
         o+M+0qky6WQrsYfjZxjqq/cUkuMBgxQ+yq8Ua8LtJ2k2HOeHhCUWUHpV/bGLsSiBiFwl
         +J33shArt6ggX2Gblg9AbMT1t3R1aIdV07ei9hhBNEsUJ6T4ShzExx0JYSZ9J8dwInM1
         jrBkGajZaPX6JMQ2hJU1KTVaVHJqTqbt0IRJpVUIMikhE5cQ6HN2tiOzNkz7cqcVRzYm
         ru27Axvkxn65r8OfhKTX0cxvrguMS9CzCLXN4dZLdJHC/YLxVXFdOmM5dK3FALP6JGlj
         mmzQ==
X-Gm-Message-State: AOJu0YwWGFPKqkGoZmFGcYgPLKN33+mey6i0czTen5KjRoLJWnPw28nM
	LiBs+2uNWg/g71QSvpyPeh1Ri/4ztxIP7lT2cGi//jIAvthRtkMwgBbzFl5GjgOkE9bhVuHPgjM
	chQ==
X-Google-Smtp-Source: AGHT+IEg/h9s1d+Swx9EJYfMUgBN/ifTzPWb8HrDxhF+oosvBsPlL28UkAI466cJzdn/BGYHBGso4LvRogE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:a142:0:b0:61b:a123:1c53 with SMTP id
 y63-20020a81a142000000b0061ba1231c53mr168083ywg.4.1714422895519; Mon, 29 Apr
 2024 13:34:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:34:36 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429203441.143607-1-edliaw@google.com>
Subject: [PATCH] selftests/vDSO: Fix assignment in condition without parentheses
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compiler warnings by adding parentheses:

parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
                if (g = h & 0xf0000000)
                    ~~^~~~~~~~~~~~~~~~
parse_vdso.c:65:9: note: place parentheses around the assignment to silence this warning
                if (g = h & 0xf0000000)
                      ^
                    (                 )
parse_vdso.c:65:9: note: use '==' to turn this assignment into an equality comparison
                if (g = h & 0xf0000000)
                      ^
                      ==

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..b9cf771006da 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
 	while (*name)
 	{
 		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		if ((g = h & 0xf0000000))
 			h ^= g >> 24;
 		h &= ~g;
 	}
-- 
2.44.0.769.g3c40516874-goog


