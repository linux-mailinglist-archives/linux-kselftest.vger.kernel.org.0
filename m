Return-Path: <linux-kselftest+bounces-8766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04A8B07F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BA8283949
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15E15990E;
	Wed, 24 Apr 2024 11:02:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDDD1598FE;
	Wed, 24 Apr 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956537; cv=none; b=p9cvVf35A4VrkvukOw7ttwT4JhU3VVN89I2VrqFmFPDn9Jxye3/+/wTn595BAE2e4iLWjx/1fxa7gdxBQr/Thd0bBHDSKAkUtLcVoltpD9TIpsT9ldZJt6gwNpejS3fRnpHfkIStBO22ZHK6a8VxZuyN/X+vFctgKLD1CUhVaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956537; c=relaxed/simple;
	bh=eNzHajL0qQDlqtt6urcBwZZSf51/gpF1z416bIflBLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz1SimuIlQD3wkd5qUt+VYu1KZa0wG7vz4TnAVKstL5AUVL7vaUVvTgJhKCydVJL7dLc5j2Ii+02kKX3Lw6oVzXkIDFCjzzQS9WdVK0/GpZX+ZUyf8poFiYaVX4Zlgajm/F5t95m7a08uLrYJx98fthg16fxptbPcME7BPSbSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB773C113CE;
	Wed, 24 Apr 2024 11:02:13 +0000 (UTC)
Date: Wed, 24 Apr 2024 12:02:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	Mike Rapoport <rppt@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Message-ID: <Zijms8ikH7XiWgEx@arm.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
 <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
 <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
 <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
 <MW4PR12MB68755A569FE893DC72D86616B9112@MW4PR12MB6875.namprd12.prod.outlook.com>
 <e001f009-0aeb-4a59-950e-3e5ed1c55751@redhat.com>
 <3e14ad32-17da-49fd-a4ac-8f87f9151dba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e14ad32-17da-49fd-a4ac-8f87f9151dba@arm.com>

On Wed, Apr 24, 2024 at 11:39:23AM +0100, Ryan Roberts wrote:
>   - Have a chat with Catalin about appetite for soft-dirty on arm64; But likely
>     that will be left here until/unless there is clear justificaiton that the
>     use case cannot be met with uffd-wp.

I agree, I wouldn't use the last software bit if there's a way for CRIU
to eventually use uffd-wp.

-- 
Catalin

