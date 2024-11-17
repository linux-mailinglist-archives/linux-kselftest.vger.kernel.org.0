Return-Path: <linux-kselftest+bounces-22153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918DC9D03CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A41F2367D
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D391BD004;
	Sun, 17 Nov 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JFtnhF5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A51B6CE2;
	Sun, 17 Nov 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846341; cv=none; b=noIoWtNPGElRa+g6UBVL7E6dbBpMQHxLGCvuuWh8ZjfxmC9f7i7MUc1xYGc6oBfkYsIJhLYJmHy5ex9OGlWvl4UraHj/7+ksrs8hZ0X/RgJWDLdiGW3FMi8oeWouGA4mvQNGBOwwZunTlbTc+F5E60Dq8VJNm/Fv0g9BK3ZOyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846341; c=relaxed/simple;
	bh=dK4Z1fCNIR54b5tZYNpPUZjnEHi7AQ9yKXRRvn5u+yI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vvw6mTDrK/gdWc7PeGpWhCJEc5xoSSoTfk5wlfK1vhIXSKLc6+Mrdv1PRNAVItTQ9t+jOlIwDV90R7jWs4F/lCoIXBdN6cCWOiW82Kr9rU1sWgg2F+sEPaqlHGRiN3natAYuGFGi999MbCyDg+s+H+3FTud0VFdaOdbzC0+Z7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=JFtnhF5I; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846336;
	bh=uPqxzh4mL68Z4sQxC/IdKSxMOi/CnvBFxlpyAqi3H4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JFtnhF5I97xVMil2X58ZapbP/ovkjzlcV55oxBzfkh0lfqCYil1K7tyg40g+NkFQE
	 RJ0oXMz/8bCXm+N/rWnJsmpe2CAcBTInYtjFDaonBz8nj73dVjwiDngQu9oilgB1du
	 rE8TjIpb1ybm5wAKmTs6d6rvgLRfS/yDcwUm3SgFEKzki7b7VGR5MUB0GcipDkf0O9
	 Zw+MxkFMAHm05TGRp3h3dq+ZQfOOD77OOcskM+aCPfXFY0il/7FyM+TAWLi6LElxKO
	 oEywP3jCbK8fTkBv5P8C/1VNeu/uiBgfBX9D07t7EbVyuAlSwvItM1kDjgFZnn9dGx
	 G9KlMc5K4e7Hg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XrqjD1nf1z4xfk;
	Sun, 17 Nov 2024 23:25:36 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: ritesh.list@gmail.com, zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, shuah@kernel.org
In-Reply-To: <20240930012757.2395-1-zhangjiao2@cmss.chinamobile.com>
References: <20240930012757.2395-1-zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] selftests/powerpc: Remove the path after initialization.
Message-Id: <173184539763.890800.11338398179510571377.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 09:27:57 +0800, zhangjiao2 wrote:
> If there were no anamolies noted, then we can
> simply remove the log file and return.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc: Remove the path after initialization.
      https://git.kernel.org/powerpc/c/7ca93aa9204b706e4afcd4fae0dc8798500598d5

cheers

