Return-Path: <linux-kselftest+bounces-4605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A57854089
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4AC2843BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F16351B;
	Tue, 13 Feb 2024 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRCWghsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE965BDA;
	Tue, 13 Feb 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868667; cv=none; b=pt4V90ptRADKAZb8/vmzPmSrBXQj1D+icfN3/pO1sJBsiWa4Ug99IlUL/YUODYDOXGvkAiLIFw5Kk1uhMDREljU7mrm4UKltoCElJOkli83barGiXhRigHydIUkiMC4OIg6iv/7D7IEn6SJBBo9Nulo2WTDcGcifXQ6Tt9jBu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868667; c=relaxed/simple;
	bh=fhrVSMq7W/qM+dE3xiVk7RqwqKuIwqDKLHiYuclambg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PEZqnC/NSKNDC/rVw1PpYW+oHLoPwi6v58D8AzLlhCog7HFSHJ3sPfIrbQ9gIh9ns866b28XMn/tAeT7gvieXp7NSBpzxuK8HJqK40bPc+y3oequkNGAd91FRw6PAWGF5dpe03gKNfW3H1prQcXuFS/wF3dNBRNUX4YvFHyit/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRCWghsB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-562117d3dbfso445120a12.1;
        Tue, 13 Feb 2024 15:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707868664; x=1708473464; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4gpiGn9ejifW2W661b3tHT38q/IiDuz5CtzD82Voig=;
        b=LRCWghsB8lQfhcbd8BSYOKyumRo7IIV3E7wRC5U4TeljM3BN/d3cMHtly21jijWajC
         67VurStYYNRT59mkSTJl37hr15/t2F3A9AVg1kOHx8DpadOy7a3FDwtYvi3LyFSfeXpw
         47Xj7QZNIGSJ+4sxQF3XFXz6iezkm2VJ5vFedIjVrONn89Mn6hGb9DQuk0RtLFSvrVLk
         qdsuti0ULT+GH5Mo6E/cFDtJ3svvvkDyLbxXOQaG4dUf6uaX92ifFHs6JTFzBLaIVtw7
         HFYgqWUuvbC0P2eJjF32NojSGlD+VBDghU6JFQTLhBV3TlTs2d+/VRnkDpItpbRLD8oR
         5iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707868664; x=1708473464;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4gpiGn9ejifW2W661b3tHT38q/IiDuz5CtzD82Voig=;
        b=BUoPiXToWi6rfu/kvrslUb/DwpoPAlPHfUdAL5K/0G8BuFKW3RgSPJzs4Hc08IOE26
         1StGCf0KFl/gQ43J0jfsgkoqFWo4gB2Gb6Nemvc2qYCN+8Mb9Ov34ka5FtvRbhSp/hLl
         zXOBeHfDAPuvVsl4GAA5h4d0fQ3FjRD45eVHemDIMjlinVQSLH0d12LT2KQ6zEizYaIM
         avVEUW0t9RxUmsz6s8MCCT4MB5qGOtZoGPmGpYQFU8s7qn+dpAV9NJD6IqL3uQnRx0lc
         n+Pa0ima7MuInWmfs1f/7bK21e9bmJ47MppCu/S1UWGXc/C+KVDH48dSLl7K+M7SybKt
         amTw==
X-Forwarded-Encrypted: i=1; AJvYcCUWy6QlGp27ZfN+Ouapf2GoS6SpOoBO+srlfBugRBDCqWVvTkpIjbq9rqH5U2wBsrXMjMYpfllijLWyBY+PKt0qAsWIHILUxinRb5JXI+pQ8m9vIXCT3F1JJUdrFh6io73Vv8W8FgyS6fTrp1mz
X-Gm-Message-State: AOJu0YyF2aBSGTeLrXCXy3r1vntldll+uRasKWnrufT6RhI5w66VI1E2
	vc248gJayjSuPXMVTCtWHNmtpndAItNqQE8zuHquhcIeEEHVENna
X-Google-Smtp-Source: AGHT+IGlQQQDH+S4iZPiaQ5jrgBJd+pIGXAEKivUjK99BY+4/U3qXLl8iwV+vtsUcBLFAeWJ32kk/g==
X-Received: by 2002:a17:906:5a8b:b0:a3c:2fcb:97e1 with SMTP id l11-20020a1709065a8b00b00a3c2fcb97e1mr296391ejq.13.1707868664289;
        Tue, 13 Feb 2024 15:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnMdPyVZ1LmJ1rv06or4UJxNCK0LNyfd3bVwoXP9Nym3o9iOZKS6SdbT18B9B2Bcmej9Dg9DckYSxYqP9bQagdNWp4+q0o0KPeU93M+bclwD9rKeT+cH13Smx5sxpDoezzkZoDYs2FhkZN5kUO+UjOtvdywdiMPrVC6IACKHqJR5nqhCyeeWN+7GB5PuQzAhQ43/AbOygtcED9ZsJaD1rE/MnYmTFlbH/H48116GT9lvqW/Pxes9byamsk4aMpjsmOCi8McNj25Amw+eFwnQ==
Received: from [127.0.1.1] (2a02-8389-41cf-e200-68a7-7041-4298-e66b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:68a7:7041:4298:e66b])
        by smtp.gmail.com with ESMTPSA id hg9-20020a170906f34900b00a3d4305a105sm63190ejb.215.2024.02.13.15.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:57:43 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Feb 2024 00:57:41 +0100
Subject: [PATCH] selftests: damon: add access_memory to .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-damon_selftest_gitignore-v1-1-f517d0f9f783@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPQBzGUC/x3MQQqAIBBA0avErBNSKqKrRITkjA2UhiMRRHdPW
 r7F/w8IJkaBsXog4cXCMRTouoJ1s8GjYlcMpjFtY3SrnD1iWAR3yih58ZzZh5hQOd0NvTPUDUR
 Q8jMh8f2vp/l9P1Ply9pqAAAA
To: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707868663; l=1010;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=fhrVSMq7W/qM+dE3xiVk7RqwqKuIwqDKLHiYuclambg=;
 b=CyfQLLd1lVsqKj7HYORRBa3nb0qwpRuYqFeHXxSnz5DoaEivTccJJ7MPxRtJ6cTYndaFZmXlB
 MRA47POfSk8CUB641MYESMHtNzl/DIBHgqsFOKLe1WplkdcJYsjpIm0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This binary is missing in the .gitignore and stays as an untracked file.

Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Closes: https://lore.kernel.org/all/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM/
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index d861701f0327..e65ef9d9cedc 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -2,3 +2,4 @@
 huge_count_read_write
 debugfs_target_ids_read_before_terminate_race
 debugfs_target_ids_pid_leak
+access_memory

---
base-commit: 7e56cf9a7f108e8129d75cea0dabc9488fb4defa
change-id: 20240214-damon_selftest_gitignore-d1586d2f58ff

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


