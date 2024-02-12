Return-Path: <linux-kselftest+bounces-4528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637E851E08
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52306284619
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8C481A8;
	Mon, 12 Feb 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks6bLbxb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C04776F;
	Mon, 12 Feb 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767022; cv=none; b=B0ddh364gUe7J90dFy9FTy9B3i3pzT2eps7Y9a4xzcBXoheBbsDky4e1t73KYpAjJD1gniqyNYbppDDqHtN/ilAMs5zWphg4TjRGcLV8umMNh8AzvrFh5NOfzrgiUIZT9cb5iRWOQF3JiITPfCMlMMnM579hXCEjRm1eyfpnzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767022; c=relaxed/simple;
	bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg7p9bG6pMgnXXxWM8RgUD+Cz0eeUgCO3EnHE5COjUsPxji7NKgwWJ31FzKyWGKNR22WDQkxDbPIyBZBAzBGdD8j0SpSpCHDSMecwigu6dKruSR+FGdDM1vapfTRdRWlWvN2D31UYMVne08ena9FMbTLeCRk3DSkXEXBYaQH0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks6bLbxb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so482820466b.0;
        Mon, 12 Feb 2024 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767019; x=1708371819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=ks6bLbxbqXQQWNl73UZtIJnAXKUuaIYTb7jLAmKweqoXvqeSPe2WY/MigXXk3PU6pZ
         759y/BKzlEMsflKdwfZCH12/gAq9bNgW/poPAvAA7ISgm1AR1X5huS3Pe3PJlth7lyTF
         8FrG0ZXsdYDRiUVm3VCM8WvJQ1vVoiVrGfQ39hBFRH4gorHgYyVbKIr2HYDFiI55sSqb
         7wNlEYJJezEzU+0+YyJZdkCsp5I6z2gLcwBMUz6IkzpJrgg4IhZfLtEUE98l7OPxuEU8
         UWg4t+MXi7d57wgF4KU+aD/MGss7/oE4yFaVIXk18Sb8lkqJnJpGbY67+sgjtRUMKhQz
         QUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767019; x=1708371819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=UcpzLkWkyS0J49Ave4lgFyOywTTNvymvw1rA4nyTEUzTbrBa34kCmcwQZlq3o/6r6v
         fCJ6lsz8FAw+Q4ET5aUVeek4uVqlUKR5Ztsgfshu5if8pCyJp2575iy28hS04MefAVJB
         EJKQqvR/AfZu47PM2qZ7eNb2GkJ4u5qddeO1K3coHyM1l++0aqI23O+1MCkRDC2Z3m1w
         DokMwA20Yz3asqFr1NL0WZMC3yPxysfMbcNuFPKEFid856ompiINK/Hx+xd5WOhJscfl
         U3C5obiYJlXIGLVHdcFNBnGR2+JALWooe2Y/6RD43fd7Jz8UMtjk3ENH78NtGyVmtqrI
         w9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ng3sw5bUTVVac86b+lC0dsdOpTgamcwBIu46Przn03kRUdcV7zn2RzlSqtsl0Ab7vEeDfXuZVAwwWSXW5LSDDNrMh9gIItZ/wazB
X-Gm-Message-State: AOJu0YwhFt5UAAXdrxa2eYjpFJqBjit/dfpsCh97NxKT9l+MOY8zkvD4
	Rgu2WGrPa3QEPnLe1vnX4gnAEfgA1zyQnPoWJ/BCmhQOGTL9n5Si
X-Google-Smtp-Source: AGHT+IHwhObwAJmnYwqvu9MYKQ6IcT6WU6U5gGizU5ooPxRkv0ccZNWPTsS2bXI76EifnDCFFSw7NQ==
X-Received: by 2002:a17:907:b9c6:b0:a3c:843c:6d6e with SMTP id xa6-20020a170907b9c600b00a3c843c6d6emr3691563ejc.15.1707767018935;
        Mon, 12 Feb 2024 11:43:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4WsBjIbRwp9Z04SuN95f9z0hvmdY68+8W/ECfjK5iDKO27rvwzuzsWYFttpYhHLTbnFeRmW5FEKXwYBIKAWFHqN7C4GU6w2k1X8PqBzhW9hatjikRcz1pHQDIR9+KXudNaRjKbept6x0AO9Rejo6IikF2INockUyKpPHrjf+YjmxhsoQYp0bfsF0ie6IVrIXgQSoBg/ZL+CDHMdCNltkXVSYk/yVWuVYhQl60ljwSGKaDSkAGeC0QPH21Z3aN1hfX
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:38 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:36 +0100
Subject: [PATCH v2 1/4] selftests: uevent: add missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-1-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=672;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
 b=5ZgRb5GVufPB2pMDIOqRa2V2z0FkI9qlAiELwAb4h4Pf8gZ+Q5jEhCnqFlDwZaFMwt5dyztIx
 FbZEdTJs7GWBy1RvOpDpVB8hCPPJvlm86EfuAryrRSZ5usjrIQw1HnT
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'uevent_filtering' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object
as stated in the selftest documentation.

Add the missing .gitignore file and include 'uevent_filtering'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/uevent/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
new file mode 100644
index 000000000000..382afb74cd40
--- /dev/null
+++ b/tools/testing/selftests/uevent/.gitignore
@@ -0,0 +1 @@
+uevent_filtering

-- 
2.40.1


