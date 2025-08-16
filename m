Return-Path: <linux-kselftest+bounces-39154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F78B28E98
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0061817A69F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5500822D7A5;
	Sat, 16 Aug 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJzySBZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34558462;
	Sat, 16 Aug 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355585; cv=none; b=I+TOcpw3H5dOljI3Y75Bugr3hcdao3Jv2gHH7YS1zoEiJfMwaUhuKVeVZGcDJ4zIzqkCXBJJZ6OvdJupomw34IItnuh6vp/Ot/te4wPnPGjXbmKItGjLi9g2VPAdvgAc3tei3DuRsgKmXx8jX9ReW/u5apyh8hyW0EdinvpP2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355585; c=relaxed/simple;
	bh=5aaRUSH/4btpHZ9YU0dxGdPsemsBQH/FhjTp881Z+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mham7aDckXmAsvH4dTz1S+umMuvPZzNI2T1LNUIeNhW271J6x7x9qvT06i6T6Z8Vvrtj7yde8rLHg6vkcg5jj43xVxkRMYG/C9PbH2R7imxXkjcMCuDoo2FroEAj5mvGaKGON5MHkgNiZmbsCSF5Ked9xiciL9UDdDKoIe9i7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJzySBZ6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so4351847a12.3;
        Sat, 16 Aug 2025 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755355582; x=1755960382; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw+P/Pa0Dw/S93nPWnlSUfNlUoEoEUunc4lH2vJItmg=;
        b=cJzySBZ6IldNtRgM4U4u7E2NpOgBEyLvm0mp55GTf+C58VeDwWsHVUhnfU/psS9U61
         ORMWAsQ8sXoh5s3JN3U7ExBngUEdJ2bNlMRsyTV22JmlRrsPREuwID12dcTD/poE9/pD
         +PC9K3KQyN2voNZB44I3Ng6rX5pM9LDZrMVD8X4RZc8ltjLe5cRw5tUcQkXt1AoiZAoa
         2Ot7RpbTvEYDoHbgU7Nzs4WsjYTKBQFjlV89ie8ZPGp3RHgRu8XrrXq3FRMZGKjfUrcQ
         TkTUQnT/kBoBs7hLi4GoNKCnX+TDJY6znhFwi/E133lQyuB3DK0cyaD6/WpY+mX0MxKY
         5TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755355582; x=1755960382;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gw+P/Pa0Dw/S93nPWnlSUfNlUoEoEUunc4lH2vJItmg=;
        b=SYWNDuia2o7Vz7ay/sIv/7OFayBgmz7jY5nWEJDCV/9C+NDS1r4EdWntJv5W4mFUbS
         OQi3dmOCwhq07acHH0ViOt8R8gDjvgPv43hoQ81Hl6U7Cqbquza6M0T4TbfFMBidTy9N
         OqsrB1Yqhg4J6Zi3+15VzaPxXmWA5rhu68tFvBf5U5i9Qpv8n7oUDIxqfk7yLn8xTKcY
         pvcXN47Tc+o2b1pm0AbzuAFIHkhLkYWpaQOiXCwAGuZ8QyeEBJEGjO88fhe+CkSnEjFT
         xl6Kd/6FDJhhjda53EUk543jk1Wkc89UntgHnxn2I8lnIS5QVdlMZ3Onz6XgyowTQsYd
         e3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUEerzD3vtNjw3B26kcoJP7L5dIfW9xVskYClrz6G/+uFoFHW28NWF6RR4q31tfcbae/F5VldajXA01XMc5e6md@vger.kernel.org, AJvYcCWHCYDiCWRXAquYZXSoJUJoRnOApux3vfm8FH7OdFqG4GEWNdhbn4+PCujzZtPxRzc04kwgmf74QOCnTM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpXHby8UhuSMp4p7zQxN8jdNHw5FMCPzUDmvwNH4GvtuBsmoK
	rYCmU+gV7dRUYBnnVvlr0yAnJgFjUZdpcPmNyBwm6KoI2v+tDljGMkgO
X-Gm-Gg: ASbGncsHOF6TOdciwSewdWBCWCgKsctyFlWbBRHlYWfzVwukVLQ8aLv+7S2zKwMXFM5
	xzfvqfBnC0bGVOKXpeXI0uoL7Al+ORxCCNVDJRtK6iYrCg2BbVGjl1PwuMSSOtAzRETK6XStQXP
	VNwGuvTS1HEhJv7fWI/H1wlaROke7QOKfNq7690Nm+FZJ3xCelkG6RdxJVZF6orky3g4ci+R5iw
	/LoH1ey2bb/WgPp5TtPo2ZDOuQWfUCuOyk+F46IWLC5kbqJAFqYl2wakLxX+1NMMqeP3/0Yxo62
	Yojzfvpj46l2mJ+T0LmH1QBTx2LcQU4OKzwSRJazYGDNZ5T/k0CyimcXPcCi1hlsScHRmQ4dRC1
	lTwXpNB9AWWNpfCfL7TPTVw==
X-Google-Smtp-Source: AGHT+IEmWAGVkWxKGm+74BpjO/R8tO3rFmp421TY2+nMdu59Zv37dPIM+ndBXIrW+4ecQTGD7IRrMQ==
X-Received: by 2002:a05:6402:1d48:b0:618:2733:1a52 with SMTP id 4fb4d7f45d1cf-618b050f323mr4526625a12.8.1755355581871;
        Sat, 16 Aug 2025 07:46:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae6bcsm3401904a12.37.2025.08.16.07.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:46:21 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:46:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 7/7] selftests/mm: skip hugepage-mremap test if
 userfaultfd unavailable
Message-ID: <20250816144621.3d4ocd44slizboxy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-8-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-8-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:13AM +0530, Aboorva Devarajan wrote:
>Gracefully skip test if userfaultfd is not supported (ENOSYS) or not
>permitted (EPERM), instead of failing.  This avoids misleading failures
>with clear skip messages.
>
>--------------
>Before Patch
>--------------
>~ running ./hugepage-mremap
>...
>~ Bail out! userfaultfd: Function not implemented
>~ Planned tests != run tests (1 != 0)
>~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>~ [FAIL]
>not ok 4 hugepage-mremap # exit=1
>
>--------------
>After Patch
>--------------
>~ running ./hugepage-mremap
>...
>~ ok 2 # SKIP userfaultfd is not supported/not enabled.
>~ 1 skipped test(s) detected.
>~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>~ [SKIP]
>ok 4 hugepage-mremap # SKIP
>
>Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

