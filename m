Return-Path: <linux-kselftest+bounces-18158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4D97D206
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81ACB23438
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F94D9FB;
	Fri, 20 Sep 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAQ9NI6X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185874F218;
	Fri, 20 Sep 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818581; cv=none; b=oi9oWwTeEYvKJY0hv1B2X9vrklxUyR7KctZ8TnyNWzd8HULG9PkwEKhqWKrlUbkcBhk+/2XlQvXWMatrNvfqPNnc1GIHymmR9a6V1MWwxiSdze1SYkPD3LOYcdYeR9l1cwMgnzldbnHtHLjgSDPKJetvvaQzVCroo+Hmm7LP8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818581; c=relaxed/simple;
	bh=E5TyztQhkUzZwMxV++0nI5EoQonMvNCb2Tdg38mkhYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFdb3kRd+Cq77/tZhADALb1rtCVY9cWwL1nVDo6kJbdFr++AbQV2xvk+CWdNmeHjjXQy4nYH9+3pEmVM6l0HLmcv4GYTjiV73fSqBMOJSvTrDxdKT/b11XpbKHZBPjy9qZbvwp4RIhqSiH9sk5fyiJJGEUtXmYtyOUncX7Ss6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAQ9NI6X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055a3f80a4so12167685ad.2;
        Fri, 20 Sep 2024 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726818579; x=1727423379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noFg1mq/xrw7o2KWB3ZfepYrijjvn8fHawORzc/mm6c=;
        b=kAQ9NI6X1KbOfCVt02ADc9XAlpvWObHXDWK1qI80PY+DxVBBy/y3w673lrT32r94z8
         o9stwZtnnFLSoPZ/JdbpnNvmZgPl3MEO/GIxVXhDOQKaxGVFvVpimBdzdv36FNFYJW/e
         kQEFfU+plrE37XOyEk5Jms/9NaN8Q1BiRIvzgisD0iI/hqK1U7uIL7VYpd2IAQ5B3Ylc
         Q28w2jinVMD0N/p8Km9HM56mqOhvCYRNiKzn3jkjt1F32bLkQl9tkyEEy2n/hz5F3EuQ
         rgENrT8iwgInRHhlUEefvlszL6lSTxW3+Ku5tEwdCweLHDtSvvk7tInaRKjYYP3LULu8
         +mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726818579; x=1727423379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noFg1mq/xrw7o2KWB3ZfepYrijjvn8fHawORzc/mm6c=;
        b=pLxt4GfAAF5rAgJhiXaN2XUasGnijHF2VIgLsxUTWLCDme199b9pHzkgLc/JskwehE
         9B4UK2YD5XaLugmQmynbbeJn7gjfEtY2r8MdvhtFsUDiJG5gTvpKYU0V4kUduWvnuPHH
         rHp010zonKwAwup4ThBN6/rZe209sljNh/Pqhnvwe9uqDX4QXTYnxNPiVNPTGk4PYBj7
         fRXwbLhwkOKC+VDJBhvT5LUWq+xJH2JXRf4vOmMgYgP7PnouSCOCjOaMMS9G4WTprxPN
         xD2R4lL4YgNIhWxthzi1AhQcpXyhM4ffV/ezNmCyqBLdXCzwWkVf68+aAke4tYGqZuSg
         gKrg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4HCSsjAlEYQHuDuwiPhWfHRV5lzEMo9+PKYFM+IfpbckY3xRE45fttJbOV+PXLDEoHAO4l9E6+VdmLsxWqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJBIKp88ITtyOSx4n8DDYlLW7bWJ6CvZD3zU2U1iLTnrHs5/n
	dDNGrJ0ysYo3dEGWDcMnXR4sDinaCfS5YIUlSFnZn4zVZHwsQV0AHMpXXg==
X-Google-Smtp-Source: AGHT+IGJCPJ129JgNLt8JKJ4cnLDrd+a6uNiFccng6gWpt6GReTy81+QgyBIrdEUlkJwBxYTq4Wzgw==
X-Received: by 2002:a17:903:41d2:b0:206:d69d:9ca6 with SMTP id d9443c01a7336-208d97f32dfmr18860205ad.10.1726818579097;
        Fri, 20 Sep 2024 00:49:39 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fe8sm90481625ad.68.2024.09.20.00.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 00:49:38 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v1 2/3] bpf: btf: Ensure natural alignment of .BTF_ids section
Date: Fri, 20 Sep 2024 00:49:12 -0700
Message-Id: <714d7ab8a48172c67ddc027c85b2a0dad0312a74.1726806756.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726806756.git.tony.ambardar@gmail.com>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While building of vmlinux employs a linker script to align the .BTF_ids
section to 4 bytes, other usage leaves .BTF_ids unaligned and may lead to
problems (e.g. [1]). Post-processing and libelf-based endian translation by
resolve_btfids may also potentially suffer from misalignment.

Update encoding macros in btf_ids.h to always align BTF ID data to 4 bytes.

[1]: 3effc06a4dde ("selftests/bpf: Fix alignment of .BTF_ids")

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 include/linux/btf_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index c0e3e1426a82..c10b163dc340 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -89,6 +89,7 @@ word							\
 #define __BTF_ID_LIST(name, scope)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".balign 4, 0;                                 \n"	\
 "." #scope " " #name ";                        \n"	\
 #name ":;                                      \n"	\
 ".popsection;                                  \n");
-- 
2.34.1


