Return-Path: <linux-kselftest+bounces-16390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181996093B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2312B24298
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF11A08AD;
	Tue, 27 Aug 2024 11:46:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C201A071E;
	Tue, 27 Aug 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759200; cv=none; b=FSZXg1zHaMnkxtjIm0qKyJd8euWLc3lSt/+PaJsqohUc0Ns2ow2gqvbYbrP9SV3ADxS3+6J/NGW+ANBKNDG9Dusn2ANdhIv7kJWCOxDe5qJjkZza6mrYjRJb+YrUUuoswn8BoWCF6TmdoiGmxlgWLNuWDsgHp1KrS8g0FKBUwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759200; c=relaxed/simple;
	bh=BeYZJBVaaRdQYTVF/z9wA0AVZ7hR6FxmgsnSaTTH6bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvmHyJaNmYHYm+gm9kdxX+1ZijVEfWrqw+L5r+Bd8jGfyuk9v2Q0xM7LlQtw6riJB8wcqWW1fweweUq6TQtYMoF3xhZHWVsfHbgNWOAhfyQAeAqAdACbeoWBBw6mffq0VMI5wFmJ0DeidDGey12NnyBee8wW442e4hPldzw1/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B49DA7;
	Tue, 27 Aug 2024 04:47:03 -0700 (PDT)
Received: from [10.162.42.26] (e116581.arm.com [10.162.42.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A586F3F762;
	Tue, 27 Aug 2024 04:46:32 -0700 (PDT)
Message-ID: <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
Date: Tue, 27 Aug 2024 17:16:29 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/24 17:14, Shuah Khan wrote:
> On 8/22/24 06:14, Dev Jain wrote:
>> Rename sigaltstack to generic signal directory, to allow adding more
>> signal tests in the future.
>
> Sorry - I think I mentioned I don't like this test renamed. Why are 
> you sending
> this rename still included in the patch series?

I am not renaming the test, just the directory. The directory name
is changed to signal, and I have retained the name of the test -
sas.c.
>
> thanks,
> -- Shuah

