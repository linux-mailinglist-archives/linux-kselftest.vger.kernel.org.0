Return-Path: <linux-kselftest+bounces-45059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B8C3E82E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 06:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1683AD908
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 05:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2CA28C84D;
	Fri,  7 Nov 2025 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnNGK6qS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F7286430
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493395; cv=none; b=dMhMpCBLEF3WSr2vsiCUY3vYAl9Xpbi3aInn3KjCLC3pT6osaqhv9XrXZaZynxvCMhQtIRvKAauJExc2fi+UJ+BTokSkoWrqGsDRfueCyj8+NSZm96LnfaM2Ka9Ku824bGkadvztZn4ls6+pP3fGTMELNniKBp43sG8AjTgEu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493395; c=relaxed/simple;
	bh=L03uIXQZxdkalVh9ZjTUCdHmAeF5s/msBRS6xoMrnQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=REEbyvqvPjoFGDd7Ig/tqVPaplDjleq0s9t/Oh+ctqDt/R0C6FeSRaFvryA1OsjFHYyg2shLFL7DMAAAVKef/PaiTNDOgVRvHgkCaKCvMkQI/pYOe7UOI9j1OXs1sJWqvnDpXR9XcLZkdDXO06E6kiVzSUEHfD8j89uQ0lmRisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnNGK6qS; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b24383b680so153817885a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 21:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493393; x=1763098193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=48j2zZJXWTS3tXcJmxqzEPrxFj/EkmhfLmBq2HSrPzY=;
        b=qnNGK6qSyezrQlCnKtwoFClcO+0ve8xEyIYiT37Xqn5AtoSKQ4xjxYR+V0QwJMKHJX
         f/fxqFjucLqBCwon9vb8xkI6hdey2LllJns8QdwTATb2p7ZiWlpEMtEIA65JEUhqqbZE
         5BnHCr5WNsYndgHpAQaidxqu711zSMav58/TSwxweL2J35/jo+7Y8FdTUCleZThR1qOU
         S+dYEqQD611rWvYCgQt2zDKdKkHeA+duvmSL8ZQBtOGfdZRZPHVyltEIDSWRIQvhSQId
         DuvP7LqdyjsxPS6CmgMHsqoIB+oN8EWwngfox46w3H+tow9a56kpQVL8fBKpg8QPwAXD
         lpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493393; x=1763098193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48j2zZJXWTS3tXcJmxqzEPrxFj/EkmhfLmBq2HSrPzY=;
        b=fTuaNBVsdKo4UMRIni6HJZRxdeihujjD4md0S1cmduckGU4hrrz8MwNfAGHqeRc2Zr
         Tb31xnVeyYQgi6VNznWTWXKwiDsjhvOAugnNRP/6cjBQ+S9aO3IvflzjgJUR2XM9fcfa
         4aqKcXcoeKylLj67iAyiy4prDtB4a8Q7yyOIxvbiVoaB+TiPJdeLvrc8ZSEavBt+wUvK
         SbQYBmS/rq/hbPFhlPKzmqEcqieBlrHVHpgub/hTaFerXZ9lOXhSV+xSZXdcvt2Ji/ph
         AXLGCFkPc5kebcR0yE/PCT5RNtfFt9vxVMeWb13KjedZ7QWM6oie6LeMr5AWcuhZ4cY0
         fNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Qp0RkGWi0hXQ4RFEi3ueqpBg1bCP8rHiWewO04et2tAzB4nKX3psfY6Da0VjaklJ4cIuzU6qUltwWK45Re0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DEWvriHEcfOatu6/IUX/cxNL/GzmAAp7/saSXbOPgdPBxAuG
	w0BJB7pug4nfmwlRzME8TcXkBgw2i2XgkZEkt3J9T/mBlSdOWwzVH7TuDszba9OVArzjVeIADHo
	gpw==
X-Google-Smtp-Source: AGHT+IGX6OEfniAXqNWEIhp2i9gcLVm92VZiRnkK4/N6XrrlWlAs+epPZsQEP+HqeKvwBATh/hbqJHdIFw==
X-Received: from qkoz12.prod.google.com ([2002:a05:620a:260c:b0:899:fd6d:28b0])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:318c:b0:84d:9f49:6898
 with SMTP id af79cd13be357-8b245351d7emr265794885a.61.1762493392688; Thu, 06
 Nov 2025 21:29:52 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:22 +0000
In-Reply-To: <20251107052926.3403265-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107052926.3403265-1-rmoar@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-2-rmoar@google.com>
Subject: [PATCH RESEND 1/5] ktap_v2: change version to 2-rc in KTAP specification
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank Rowand <frank.rowand@sony.com>, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Frank Rowand <frank.rowand@sony.com>

Prepare KTAP Specification for the process of creating version 2.

The version will remain "2-rc" until the final commit to complete
Version 2.  Adding the "-rc" ensures that none of the development
versions will be mistaken for the completed version 2.

After this commit, Sphinx complains that we now need more '=' signs:

  Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
  ===================================================
  The Kernel Test Anything Protocol (KTAP), version 2-rc
  ===================================================

This warning will disappear in the final commit for the release of
version 2, when the "-rc" is removed.

Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/ktap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index a9810bed5fd4..387062b96c10 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ===================================================
-The Kernel Test Anything Protocol (KTAP), version 1
+The Kernel Test Anything Protocol (KTAP), version 2-rc
 ===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
-- 
2.51.2.1041.gc1ab5b90ca-goog


