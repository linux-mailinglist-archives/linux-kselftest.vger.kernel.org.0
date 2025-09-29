Return-Path: <linux-kselftest+bounces-42598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0FBAA5B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 20:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244CB42278F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF5238D3A;
	Mon, 29 Sep 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BHxl/QZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D46225A29
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759171074; cv=none; b=edXXEGtiTVsxiD8ui4RyYHf2g0rIrC9E+aRjgpKxI8pHS+YkY6W/+oa/sU+ddqg+URFd4ZD/CipEo7zogvBAfUp+ZBErAzcNr3GqV3RAAuThsLWVO9MjnQxmImJkFVqbzVvitbpctDTbqund76MSwoJ983OuMlPLJ1OxYGOHqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759171074; c=relaxed/simple;
	bh=JQE3aDLBn4uEFiQFU9/nZ3ri3B1AK5jMtTpQbEJ6b4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVcMX8Td2MGRw0wJyQyk+RoE+TnFmz7AKCg/W0sL/EXr9G6konbx00WhKTkmRAm27y/SkeqODMdMX97WBTyyhfqXvs5opT8tSSF9zD3URQ0IzYo4V10YX8SMU/qC8vDeAQbMtMZniOhxKhWmRJVEwZCnigebgo6+NLvyJeCoR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BHxl/QZs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7841da939deso1467936b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759171072; x=1759775872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJLpaj/c6dWR6gSCWApgd6FdexxQb0VtbiytQ5OXSGA=;
        b=BHxl/QZs1adPEeaIHUBm/st0lzrEt3BMKN5WndQj4qfTbOSO5bZvldmdLTwCA4nCZk
         Jm5uPmcTJyqhhiXDqZLZLwa883jKuglps6+z64IWPxnH7jEd8dcyshN0hQ6P98uvfQ5X
         h/+E4oNTuyUkZyREUPiczW9vEVB/1pQ7KgozExmBuGyblHasxdZ5bJfhU6NplQW1i1cV
         39/AjbhWWeIqk2bDPA7xNugNHwOJsuZcOwzzS3hzDD/OuDHH+Do10qPrW/IYqbAP62gL
         cEZruIv0e4Vu9RjYVKkDRQHaqOSz8TeXWk+xmOv2gfBObl3jPP4QpTUg+WH+TtjCEk79
         C0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759171072; x=1759775872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJLpaj/c6dWR6gSCWApgd6FdexxQb0VtbiytQ5OXSGA=;
        b=V3zkBj8pIRQysRromVRA0aqzRnbCgiU9QirINo5P2naMNumLmQFLelo03H6qoqyuLk
         bL2DTJ10G8Y1ukzM4J7DLk+uUPAuVWPSHeAb1DteLGC922SYqWcPPU3h6Cf36pBBCuJY
         mOOWPfm2qol/KbLT1lBXWzF+QiuZ3qM/1oTeQBWovoyvvG9DmIyUFTsMEVIaXbetEPVi
         94C6xP59dja5p4BpSy+Lyn3DNTxc9ik+5CeGPLCvJ8l700rekrpWZh+lqnOTQVB4mnBu
         PQdlxwrLV5ruyz9utsK7W9xSecyjkJNwNkfXWHl4PbKRrGYIvkyyIsleMms2GXkuBaOd
         qS1g==
X-Forwarded-Encrypted: i=1; AJvYcCVoGnwQEJM8ZhuYRDeTAPtIlCJ4z0iPBvGmhwmJGMfllPSBLjZ8/f2/oSWMoGkP8E2EOj6BRynsRZ/pFzODqn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YychbRy5d1WsYaVDWuM6Vcwq9hqBP9BOvu38JcrNmWh+XysG/jt
	wdoN6kyC8v2jOGoozcil8kOe9xBuwvHB/+e+ddjgrcFopuqZXhX7jO3EQu80QDK7gP4=
X-Gm-Gg: ASbGncuoeRUyFjo8OOsFak5N+3yAmhRM0zOaOIzbTtL9n6XkJv+ohjBUCea+TxT2GQy
	hGdhDXutuuw2ikyUxgsiqgBCUa82O2AsgpI6thSbertuLQPLoCoEQbdy7hF8pnHYbpJY8t+vaMf
	27asSSUZ1lqFMHcZ9aVMrvIObO8FWUYn2gge8LAJ4c2fi5bC08fXRoylDv3Y/ZeYn0QMnVGluyK
	2acV8qnwNLF0+sFslo1QLjvJoBUl11T0J47v3XcmmP6/l7Rs4SoRaYUNnE/6mZuUMJjz6mkz7SU
	8oD7eY7K0B/q8e870R43sJ3OsPVaWy0nvmBH7ubIC/i859a+hHCcfih04hNk7hfz2ERWebT2cZ4
	uyb/C4nw9rlnrEqOPr2kvEUbHBhUidLe+
X-Google-Smtp-Source: AGHT+IHBfLpwSOdsOZ3rlXG6ZEpP4ToRS6T8QkcIX5AOO47fspaa/84bLNk9yI3gfkzoA6f1KMT5jQ==
X-Received: by 2002:a05:6a00:138d:b0:781:15b0:bed9 with SMTP id d2e1a72fcca58-78115b0c301mr15805467b3a.17.1759171071800;
        Mon, 29 Sep 2025 11:37:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1873sm11683639b3a.23.2025.09.29.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 11:37:51 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:37:49 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <aNrR_TD5JB5dHJ5b@debug.ba.rivosinc.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
 <8aab0f36-52ad-4fd6-98c3-bcdba45dbe16@sirena.org.uk>
 <ac0ceb09ffaeb1f0925b61ed1b82ee6475df2368.camel@intel.com>
 <604190c7-5931-4e74-a1c9-467e52d3001b@sirena.org.uk>
 <eab692794cbc82080b708c581efd5973b6004be0.camel@intel.com>
 <5397025d-7528-4b9c-b38d-b843ab004f47@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5397025d-7528-4b9c-b38d-b843ab004f47@sirena.org.uk>

On Fri, Sep 26, 2025 at 05:09:08PM +0100, Mark Brown wrote:
>On Fri, Sep 26, 2025 at 03:46:26PM +0000, Edgecombe, Rick P wrote:
>> On Fri, 2025-09-26 at 01:44 +0100, Mark Brown wrote:
>
>> > I agree it seems clearly better from a security point of view to have
>> > writable shadow stacks than none at all, I don't think there's much
>> > argument there other than the concerns about the memory consumption
>> > and performance tradeoffs.
>
>> IIRC the WRSS equivalent works the same for ARM where you need to use a
>> special instruction, right? So we are not talking about full writable
>
>Yes, it's GCSSTR for arm64.

sspush / ssamoswap on RISC-V provides write mechanisms to shadow stack.


>
>> shadow stacks that could get attacked from any overflow, rather,
>> limited spots that have the WRSS (or similar) instruction. In the
>> presence of forward edge CFI, we might be able to worry less about
>> attackers being able to actually reach it? Still not quite as locked
>> down as having it disabled, but maybe not such a huge gap compared to
>> the mmap/munmap() stuff that is the alternative we are weighing.
>
>Agreed, as I said it's a definite win still - just not quite as strong.

If I have to put philosopher's hat, in order to have wider deployment and
adoption, its better to have to have better security posture for majority
users rather than making ultra secure system which is difficult to use.

This just means that mechanism(s) to write-to-shadow stack flows in user space
have to be carefully done.

- Sparse and not part of compile codegen. Mostly should be hand coded and
   reviewed.

- Reachability of such gadgets and their usage by adversary should be threat
   modeled.


If forward cfi is enabled, I don't expect gadget of write to shadow stack
itself being reachable without disabling fcfi or pivoting/corrupting shadow
stack. The only other way to achieve something like that would be to re-use
entire function (where sswrite is present) to achieve desired effect. I think
we should be focussing more on those.




