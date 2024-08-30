Return-Path: <linux-kselftest+bounces-16761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1B96588C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF739287894
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F0165F04;
	Fri, 30 Aug 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7vYhx/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081E15F40D;
	Fri, 30 Aug 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003002; cv=none; b=CzUhi9VjDVoGJfsrDYcH1BO2jCDAP/CWxxMc9HYy2AjL/fPxTlPf+mgOq68111hO0BYFwUFreLXcum5/U6A8sVCZ9IEgtv3eW+tdI38AOTarBE5VAFRuqIPj+sPn48KlfSbPd9pkjUGAcl2W5DM2lY+A1qu3i0173nfU/Xwp0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003002; c=relaxed/simple;
	bh=UJoIZbAwd0dcyPldGPlUH3SNsQcKTlS8LGIL6P+fhDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuCnwy6VIYbeRsdH6oF5uvCHrilbs7HK03uZ4y+tMY/C7OWHlNmMZDIISkTIF+DBw1Kb12syg6ev2sEaenZjMdH5uM+idqf9cFJAfm2n1NM7TIwnL0eMM3ONcwVDR60LqcYssDYXSWw750xiXAjSxFU86dlJ0hlWIRAeSLkGeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7vYhx/n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053525bd90so872585ad.0;
        Fri, 30 Aug 2024 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725003000; x=1725607800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=a7vYhx/ngRj5sExYjE1DHzE3ADfr5r8Gm/A27CxTM+XeAY4O7eJXH7hWJOoqJaf/2o
         EwqxybeChTAkCtqJVOa7jPBish6nbrouulgnOdrSFIn+tLvS9LSZQ/sI7e2CJiPV7u/K
         rMWWPQb99EhaYQwhyXQC+KhN8Dx4KZRPSjgYmOM5YYudOFf70eUquBreg5WixIk9kHAo
         I5vtmYzee2neMTVQnut6rPrVa+hu/iQD9wHl4179mkLjVNnB1ZdCwKQE+03UwNDs/iP+
         HwiPC+VSOGLipZHixjSN4sKIgGbjwO/CED0Xxb0RMQ86fjDtd4Bdqxl/Eah2+eHrMnwr
         u8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003000; x=1725607800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=lBxql31IK7P84/YlMryvMeosGxLeSvrUl6KPTvihswwmxGPgPOAMNtyst2li4TOmah
         FwW7yUGlh9mWeOTsXpzxSiZ4xZ/5iFU52PaH0fzS93vkcrTj/2nQbc6+ErCpGz5WEG/V
         9v4jeaXuSwcKrWEv0IhJYsAqS19SGWk13bAN8AnJb7Oujp/qBvSTsLezYAvw/i2U5skY
         iXXXJzU2z6mNW6GH4ybmix52d+4TUTOWsyHnRLAeWfZmMN0gSCBnvHsxKpSsLVY+MNoV
         7/w3Ux8LP7X2XHQMcsjTO7GcqvA4JnNqKqVjtClLqB6vTtue5SCxRbRF5fNZp2yrVLDj
         sbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+qd4qgAxNUOhJoUt9To0lTTn6I5HU+GXIcWVnPFdyTJh2vdOk0TXCl6ZddAypZ+j7Iectq/NBjumMvSm5zfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnxyvYpoX2aCvtHT4LoLTlDHgNKLb06rviVmeD34QPau5kDPi
	yNAtTiH6NMRunXUiAJvYRXqinoIJgMlL+HY6Zl+V2gFdT+07iiyjgSmxJtgj
X-Google-Smtp-Source: AGHT+IFaw8cTmwpVNWzGzOfOyWf2b9H+orw8klmZc0zkB3oxfED/PsP49GM5HDFZbwThURgqnixSDA==
X-Received: by 2002:a17:903:41d0:b0:202:4317:79c1 with SMTP id d9443c01a7336-2050c44cc9bmr50547695ad.37.1725002999873;
        Fri, 30 Aug 2024 00:29:59 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:29:59 -0700 (PDT)
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
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v4 2/8] libbpf: Fix header comment typos for BTF.ext
Date: Fri, 30 Aug 2024 00:29:24 -0700
Message-Id: <b8891890b42a5b69b3fc3f78484e8d0ecba50ae2.1724976539.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724976539.git.tony.ambardar@gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention struct btf_ext_info_sec rather than non-existent btf_sec_func_info
in BTF.ext struct documentation.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 408df59e0771..8cda511a1982 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -448,11 +448,11 @@ struct btf_ext_info {
  *
  * The func_info subsection layout:
  *   record size for struct bpf_func_info in the func_info subsection
- *   struct btf_sec_func_info for section #1
+ *   struct btf_ext_info_sec for section #1
  *   a list of bpf_func_info records for section #1
  *     where struct bpf_func_info mimics one in include/uapi/linux/bpf.h
  *     but may not be identical
- *   struct btf_sec_func_info for section #2
+ *   struct btf_ext_info_sec for section #2
  *   a list of bpf_func_info records for section #2
  *   ......
  *
-- 
2.34.1


