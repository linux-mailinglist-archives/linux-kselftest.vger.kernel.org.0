Return-Path: <linux-kselftest+bounces-17360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390196EB12
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375151C23D89
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 06:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE112EBDB;
	Fri,  6 Sep 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aeOhAyTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4793B1A2;
	Fri,  6 Sep 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605736; cv=none; b=hkEjO667NohGsnoJ5ZSbmSNdBRrvIc+Z6R/hSjHIJ6MP9gMLj1C+/LllIua49AV4gM/q1T0D32P/aNRImVIzO3VcpVJv2HnZrYnxAC2kcWs7e/Z7UnydjY7qprmdEA4909tDLxwiz8IpBvKxdcqcVeh4aR0eMGiXmys8jsy2fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605736; c=relaxed/simple;
	bh=7UHwQaaXvNt3CAaY36Go6pRC1q+8LoxVo0q+4NfPUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGla1c9HNKJEUDwHPx/ki9GkFeXP9IdlfwhruWCavNRis3thJiTFeJyRqTAy3hRz8qwntts+2znSvR9/N514fdO2MdmimuaojkRMM08dFVPCycIJNW3J6zxt8ytxjYPLxG/nf582y4s78AraHHyBfTskvI6CubpgzNpS13tiZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aeOhAyTP; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=EnrET4kNGDWhFEpeoHo3LYqgEuatnbXr8XcSn6N7H2g=;
	b=aeOhAyTPDNNZLn5sQX1w6pJbWfogXRClPp0hIhzKDqmdUdQy4Y1bfcmoBcHdtC
	Q/t8RoeYniybXxBkyQcz9pq9H9CTTfnmLMkJ0ksVpSLAKUKe5YrYNmcHwqYRMzHa
	Ir3JONmsWaTU2wtjGyfppUvV36dq06smUGKt4jy9dqrvw=
Received: from localhost.localdomain (unknown [120.228.64.128])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wDXP5xLp9pm+UtBCQ--.7664S2;
	Fri, 06 Sep 2024 14:55:09 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	chenyuan_fl@163.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Add valid flag to bpf_cookie selftest's res
Date: Fri,  6 Sep 2024 14:54:56 +0800
Message-ID: <20240906065507.2598-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAEf4Bzbjt5xbxLXbY9UkbuCwN3Gzu8v-QuREoa6Uj8FrxvRAQQ@mail.gmail.com>
References: <CAEf4Bzbjt5xbxLXbY9UkbuCwN3Gzu8v-QuREoa6Uj8FrxvRAQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP5xLp9pm+UtBCQ--.7664S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RKGQDUUUUU
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxlSvWXAnGl4AQAEss

What you said is reasonable，but it would confuse the test personnel, as there is
no clear reminders. Is it possible to modify it to without SKIP，will give exact 
reminders when it is failed?


