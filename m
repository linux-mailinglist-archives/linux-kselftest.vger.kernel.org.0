Return-Path: <linux-kselftest+bounces-29060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C214EA618CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F3F3B4706
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F056204C20;
	Fri, 14 Mar 2025 17:59:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F7126BF1;
	Fri, 14 Mar 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975196; cv=none; b=SqPHHTLH+psGxCVpuhfNMoeXeokko0qkEs713y4jZ5uydzEYeiYf2Kgc9Z6DEPwQEuN7WNOePcGXPmfck9LfN9i9z8/BN1LFNvH0OJuwEyiu+ybt4EtlWWsflhW3Ok5y1alRZ9HKk5gqAA4eBjoflOSPtBO0Z9XKiFbQWJdCXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975196; c=relaxed/simple;
	bh=Db0Gx21LeDEy3UpaKxfP9j+CMkh1Tq77tExJhiQYujE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlhaaP1Aqa1H1BCkyxY8Rj5CnQik/uSrmULaBBuojVbd5sZRzpDA/jqpCV5q9X9AEKIPJj10aithUI1RRT+pWgUw+0H5aEB2oeP2DvD6txil11J2qRXW3c06depRAWxAxKEPAuWiUUle4opnQcsWuNVsHVTFtIvkXGmKJ7jArzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab771575040so662332166b.1;
        Fri, 14 Mar 2025 10:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975190; x=1742579990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joWV6bv3JsBp0mclWJfyzmk3Od6B8+HfkBZEbmYgnxs=;
        b=fPS2NSL3zLaScpNc/opKqI9V2u6YPrNaWeX266P/mdEncEkfpX0kikvz0p5dwHu484
         nKH8EXmEpLuNqMcfp5UCWDg5G2weCQuZZycDwmWto6rGGe98J4wOeFcxQl/FplbBD7BE
         7RkG2rEPIVoHVQoiRyh0fqfuM5NeCH/4646qFDDhsJigQAAybUi/MepkNRStgRu6Au8V
         33xkmQiC0NFg0GKFgbecoENH5HRqhGGd0QFA/NcqOguV2/n2VRm966236PXY8S9Y0lXB
         buDRr+0ZSpzeq442PbRWbogyp//fq7WcBkPs6SMZiiRn609Ew6R77r2dyfyQA3OH4LrX
         /zvA==
X-Forwarded-Encrypted: i=1; AJvYcCU2QnctPcbA1/k1WKmPzhUk9n1cGz5GLd3lPGGuvhAOgYCJ4mEU4K6pOJoRSKc679kiYqNOVxzl40U=@vger.kernel.org, AJvYcCVX5qyGVePVfRtWlixAoVxBywniJv8jHRQoOieOQa9i1b/U+NukDyyjb9JV5/1dCbiu3vyZc1AoJyOHb6Pox/t7@vger.kernel.org, AJvYcCWvUenEpPdwAZ0Rfw4q4QCyDqcpHL/7m/GFLk9ldC2vu+5XNfHEBlVOzPb/XhRHQOfJK4fyi9IF8P7H0zFC@vger.kernel.org
X-Gm-Message-State: AOJu0YwulbtRQPPICM9219LgjNR/r9t/18II0Ynz/XKO7/X2rLw7/bhA
	E2mqSfiQBKWrrc8ay/+Rf7wU5W7Tx7uS844GEMF7g7RSuzgu7bZayX5S1g==
X-Gm-Gg: ASbGncve0Z0QhXxAiLfDIOBkjhRR4DdjdrxNpqPMH9GkWo6U5rAwUGXIWdop90f4+Bq
	bBUs6Sl9mo3zOfwiKPcT90h+UOug+6oMhZ4YEJErAZp0VSEAYyLKdJCMIfTVrNvR0Y6hV4JuVv5
	hsRrj7AvEeM1Pch6hGE117yqNwMcE9fzMEGgPD2diWqZm0sCqGAykCt6PoMjPxYA104hnjmGsGP
	QOJuquljJwXucjC7G6U/DqOz87XqHRnDCDx/cfbcO4T+TDFGRZO6+4YX+ryV9AyGkHivrDDQB/4
	tHA7Eq0YxR9E1czDMyn13vtoZdFGa+nlzatUSzRLQdNHIJA=
X-Google-Smtp-Source: AGHT+IHoPmp4ZpsZnjgUVsVf5SPue0DANz6Ks8bjlrlru21uoTOCW0JqlMMBGdGXtQ/rk34hRPTtpQ==
X-Received: by 2002:a17:906:6a0b:b0:ac3:45b8:3f51 with SMTP id a640c23a62f3a-ac345b8412emr51346866b.16.1741975190300;
        Fri, 14 Mar 2025 10:59:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a495d6sm250949966b.153.2025.03.14.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Mar 2025 10:58:45 -0700
Subject: [PATCH net-next 1/6] netconsole: introduce 'release' as a new
 sysdata field
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-netcons_release-v1-1-07979c4b86af@debian.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=leitao@debian.org;
 h=from:subject:message-id; bh=Db0Gx21LeDEy3UpaKxfP9j+CMkh1Tq77tExJhiQYujE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6SnJtTZewiqRjM8o6FFXxkEiAsMEBgev9p8
 kt1WSLhEnaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bX2nEACPAS/Zr6WA8HdvjIEw3qq5QU4KDVTIN1rNjK2mbbHOzpxfjz8A5+LI99CgOzFtJdDwCg/
 DiZ8JVWUtwOrXsJHLyK1T9Z1KNnUo9LyoVu+9HqBQ1LWla+JsSVEgqtHd0D46p3kCbqff1abmOV
 NDM7lzgYyO+kFV22AygVHKVHnroDYqobrog6j+615e7qZUaOpZiL3MjLKhNbhahJJ4vcy5Gs+uc
 A4w7FNdsWBJmqUccrjnsBaHHD18Div0rdXsTXDrqZ/+jepxB9Uw8SE9FBn7/da12QHn+KmCr/p8
 a0+sHTzwvbkPBq2QglywmO86CL4hhDmRVMom/eARnBmwqiwiZuJZbK74ItIMkdqW3alyv3XGHuD
 GQ2iWD1TNuHJy6Q69bbE/k3eDnlxn1YkclmZ9XMO0/NEJkFDzMfYemZLqJ5UOTtWBLdpZOlwOAV
 Cg77CfcRFia/97jVKdLLXNZCfbaiXmsG0eqCcataqcHijDgEX+oifndqX5mpTxj7MxZeWXePE3l
 /6+0b8FNDby5ecIgSPAc3t8Eleiv7c79wx2MJDO+uTh8zA7upEUImB00xgV3tZgfdaulfyUK8sG
 tIUOUqBn6UybGDk4BLAejIFdneEvX+xb1VKh45nkM9WJJRI3t0XbJeqX9/YBSqbE8Nyk1tpExHi
 BgYDPH2XU64hzVg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This commit adds a new feature to the sysdata structure, allowing the
kernel release/version to be appended as part of sysdata. Additionally,
it updates the logic to count this new field as a used entry when
enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 098ea9eb02373..b7f7ec39e8318 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -106,6 +106,8 @@ enum sysdata_feature {
 	SYSDATA_CPU_NR = BIT(0),
 	/* Populate the task name (as in current->comm) in sysdata */
 	SYSDATA_TASKNAME = BIT(1),
+	/* Kernel release/version as part of sysdata */
+	SYSDATA_RELEASE = BIT(2),
 };
 
 /**
@@ -719,6 +721,8 @@ static size_t count_extradata_entries(struct netconsole_target *nt)
 		entries += 1;
 	if (nt->sysdata_fields & SYSDATA_TASKNAME)
 		entries += 1;
+	if (nt->sysdata_fields & SYSDATA_RELEASE)
+		entries += 1;
 
 	return entries;
 }

-- 
2.47.1


