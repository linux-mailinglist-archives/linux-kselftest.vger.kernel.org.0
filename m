Return-Path: <linux-kselftest+bounces-15301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BAC951639
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 10:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC502814C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD86E2AE;
	Wed, 14 Aug 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgN8oQY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A58394;
	Wed, 14 Aug 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623064; cv=none; b=Lyo59ShFj/qqsZu2/LXRo57quVG2SypGfYAPNBRPCZoMyEI8FCAvA0NWFHc+eCO1r61Qv5V/WXZBYjt5Lva7S6bxJpmNErBqu7hVLs1UIxhgGUsPxdBSTwbR0+j+UA2uEK3AUZQWgDDOsl7XEThf7isAXBMXgjCjFaLOWLNv3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623064; c=relaxed/simple;
	bh=zQYI2CyBp6VDnSmKB6kWAIMSX4CGofuhq0CGvnnCLjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hif9VLh86GCbqAdCWAQ/otJL85PQFcDCJTCmkZKePLdsKyhQCqohqwCrdsDAFiYUxu/4bPGgxCJYZS9qIeCxfRwhDuVJBmo7NUWZNJL/V7v5l8wM4dwOINr20HiR7eHSSSJpntFAPbh9KQrcsEeFUMdrOtmjPp+kQP+jxh5VBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgN8oQY6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso2235414a12.1;
        Wed, 14 Aug 2024 01:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723623062; x=1724227862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQYI2CyBp6VDnSmKB6kWAIMSX4CGofuhq0CGvnnCLjw=;
        b=TgN8oQY6T12TbDs2O5XVxiiuDYogyA0fLHg8DL0z244hiREqh9Z3Asa/8/qBUmGBIe
         osVZfkuyV0Q7ACC+mNHws/U/EAGgBmA5sKG3PwLb7+7e5GbrGF57ySAKsN+kH0OxkxL+
         Jm9fd/eYKy+PoCRwLsS8S8Ed2MJXwr1z62Re9ZBy83/rQfo9kSdyxpbOLrpL+pHswVJk
         m5qo52QWSRMzvjJQpksZBKU6LLkgqxI5EPvMTYwIVQlWOFkbrU47kebfJssid5jn2zvE
         w3pdo3Eya2hkcpVUL05yGfObyGxYr4ZftQESk25KGdiGW7wqHJHTOnhhF2CcA83FwZEe
         Lv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623062; x=1724227862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQYI2CyBp6VDnSmKB6kWAIMSX4CGofuhq0CGvnnCLjw=;
        b=w0oN/RpHSjsxgR4SdGxrQd2D39eQbgwz1gqPIJc68qFodnDXDVg5S82h5n0d7/60nU
         KS7zW0h3/I97ZywNuy1pOJ1r31x7/BKRUYIpCAiOVivohvmFnGAQRKG6n3HAqzhsxgwi
         xCf+mOK/QUZTRJHkjXfjLPibjoHK8Ot0g/CYi/BTUVccpEA4TWxeUd6Est5ZA5aTRUZO
         ahwtrg4V4LUGDOhZYZdCdlWW1k8f5VnzhJ5BRN4Hrn//SwhAP3qrH7E1DyCpYMVrjJ0p
         Wf1wprhW4v9yWDIgMLKWKlEQYSE09dSCc9nSLIXBvRNqzw3vRhMrqMGnuvN60PmpFDHM
         FzTA==
X-Forwarded-Encrypted: i=1; AJvYcCVdhbn5W7rk+EHgGUz0DQXMZEbXlzwoywGrDfECX1AMHPwQIqc+ILevarbvXK5fY1BP2WiutcnPsvsCMQNeZk6Zl+YONZTPCnnr7H3joKOu2pdEAlAmovz3OlDysKZBMYlxoLZruoBLf6HKGoXVokddMk1LWCKsyHYHYsw5L9sRO7F9k/e0
X-Gm-Message-State: AOJu0YzIiSidgtX+xebR1CsyM6gobRQ8798pcwv8MIbvKwLcYnL1Of4r
	DSNbjDf1gt4Dhlq+wWsQu4oqq2v7YQ3qAAyktFRBhT4bNpKw0ubkLiLxNLKL
X-Google-Smtp-Source: AGHT+IEEosjrpDepYydNQqfH/3IAYteZdHzQhmNJ9bRYCqjLuJtK2WpXw4iV806TF4Jldbv8j7pruw==
X-Received: by 2002:a17:90a:1f8c:b0:2c9:cbdd:acd with SMTP id 98e67ed59e1d1-2d3aab8363amr2377782a91.35.1723623062127;
        Wed, 14 Aug 2024 01:11:02 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:1250:5301:54db:4816])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac843640sm979642a91.41.2024.08.14.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:11:01 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net v2] selftest: af_unix: Fix kselftest compilation warnings
Date: Wed, 14 Aug 2024 13:40:54 +0530
Message-Id: <20240814081054.1156422-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813182106.1f44d161@kernel.org>
References: <20240813182106.1f44d161@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Aug 2024 18:21:06 -0700, Jakub Kicinski wrote:
> Some patchwork malfunction, the patch didn't get registered :(
> Could you resend?
>
> Please keep Kuniyuki's review tag and address his feedback.

Sure. I have submitted v3 keeping the above in mind, please review:
https://lore.kernel.org/all/20240814080743.1156166-1-jain.abhinav177@gmail.com/

Also, @Jakub, please kindly check this and revert (another patch on which you
have helped a lot already, need one small input and I can send the next version):
https://lore.kernel.org/all/20240810175509.404094-1-jain.abhinav177@gmail.com/

