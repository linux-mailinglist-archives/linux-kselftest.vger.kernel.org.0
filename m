Return-Path: <linux-kselftest+bounces-9727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDAA8C03D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A721F21BE2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580E12AAEF;
	Wed,  8 May 2024 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLtaVWag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462D20309;
	Wed,  8 May 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190937; cv=none; b=WwaikWEzZBopq8JcqaM5gjHQipCrWynZDfZPOVESPQSju4hXNmDSLVi8U9IYc39iQfw/QZGfxi9RhEL73mSyNr8zCIenVOb339FfkLv5Qhh6VrvnVking8oHpi7TgTF9MtnU4vo6Y9ag9gwCkKJyQf210FjHqYFrGVW94bpn3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190937; c=relaxed/simple;
	bh=q7pa0YfnYWgOB6Pb3JSefyh0UJ2HHmVcHneYQIPrH50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBnOcSOqggKekGIbO1UJ8NQt8yOU1LzGJjGqIAiAfJCXcNNuPQRlONvjxU11NPDzqQCC2ytOtDgcxjDg7570FeLptVOHf6e6J90CjtB895UvHzMf9AfQ5NPtIESh0HPLBZpd3W8F6CvT7v28ZjoYCE2SbJ7RQPnW75hzfHHhJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLtaVWag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9EBC113CC;
	Wed,  8 May 2024 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715190936;
	bh=q7pa0YfnYWgOB6Pb3JSefyh0UJ2HHmVcHneYQIPrH50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLtaVWag7Om718+7XkkyEv/ThcZBa3h3Bres49t08+lHLmkB/ekXvpWEY428oi0ku
	 JbYhnrsnToqMsTZBw77X56gZZNOm2hcFDrewRqxax4vLzz+CBVDSMSkNIcspTN+vYZ
	 V2qWkk7BbyNmmjhgVwYjTDij1uGifjIOx1E97P/6dxK5SySpvpj04lfnIZTHtjVQ9m
	 cGZxaNCdwYdvxoscPEwI9ksB/3/vVu1Gg1D+VfxkxPXmRVq1vO2zlniBQdXxu4uwvW
	 PUSqMpNItTuvgHpHdB8mld0InZ7RdFbOk71imBtyrjRfuGcGLh1J614QJAL5OK06mD
	 yEBJ3TOcrMK/Q==
Date: Wed, 8 May 2024 13:55:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, pbonzini@redhat.com,
	shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 18/52] KVM: selftests: Add test for uaccesses
 to non-existent vgic-v2 CPUIF
Message-ID: <Zju8lrutLRubQUbK@sashalap>
References: <20240507230800.392128-1-sashal@kernel.org>
 <20240507230800.392128-18-sashal@kernel.org>
 <Zjsa4yeD_EmV7TgP@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zjsa4yeD_EmV7TgP@linux.dev>

On Wed, May 08, 2024 at 06:25:39AM +0000, Oliver Upton wrote:
>Hi,
>
>On Tue, May 07, 2024 at 07:06:44PM -0400, Sasha Levin wrote:
>> From: Oliver Upton <oliver.upton@linux.dev>
>>
>> [ Upstream commit 160933e330f4c5a13931d725a4d952a4b9aefa71 ]
>
>Can you please drop this and pick up the bugfix instead?
>
>6ddb4f372fc6 ("KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()")

Ack, will do.

-- 
Thanks,
Sasha

