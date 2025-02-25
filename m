Return-Path: <linux-kselftest+bounces-27528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B23A44BF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 21:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162EF1898AE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010720C49C;
	Tue, 25 Feb 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbHutTCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024119D071
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513912; cv=none; b=TCvOA2NpWA8yLlvDEq/vIDRKPAbj/uVddpvhJxUiqrA5/JiEnwGCEuoU5wlpCXN2yKVYJDG/gtw37ecRH7FTANj3YjdJQDwg7+hyR+FyPzVGpvsZTz/0KmPoC/PScDBUauKgov4hTOQQMVRtaCWCiEgHD0GIPtzC1dhvtY89sVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513912; c=relaxed/simple;
	bh=ZbFhjhJzzPdU7qg4OL6BpZWoloFSSDxEJNo3uKjV7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVTK6bwbawY3eL3GMzmJe//bz7OaIJqZMdw30rUWK55RfJ+EAeFZZLqtHsInQRsQfnwiTWQshsbxUHQfUDWkQ/OVQnQUstza/SEd7JZr8I8WvkaHbAzx0c2mgubGAXWd8GAOw2nympL5xWLSEMYLPjiSAEKiZT+ureT+LAwNb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbHutTCA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8f38febso127810525ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740513910; x=1741118710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7rRRMf5SsNxWlQh/JxR+Ow4SZo3/cWOaF5W5bjLrDg=;
        b=WbHutTCAXvbtYNGoD8NAazTBClp4JfYyVb0/Ll8MUyFINrHOnJKkhdF6t/4ENPYZcg
         PjAkDk21KSB8AIdLlCVYVo6h6fMVF+pLQvRIFHdbQBhm23suhRHnqtOFcYKwt9iffS//
         en0i5IlEP3C8GifQdzIr22F/mFbT0oWYwbJwempS2DfnkIYaSnuGp/b0dGcL9HwuyKTY
         sVCcF/0+JPgZgkS+HjHrrJFKR8kCtBhNjft4njmydXj2obMkrQeXVg/5M4a5lCCPGHWe
         RazeulqtEvqjqdVhGjg6EtL7VkMPdJ057B1LD71+Qt5Y0lnfJg+HcniZvJsuCZ7ylWvG
         Ts4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740513910; x=1741118710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7rRRMf5SsNxWlQh/JxR+Ow4SZo3/cWOaF5W5bjLrDg=;
        b=RC6rHZaTmVJg8ClUV6n6Og10TX6CBIbZJxUB4rbJmlonVSGMwDx5MJZZj9WkdKlcIo
         ms1F9/c0tJC56C7quyyutkPR7np4IyAEhmUlgf805sze4zL5DbwlIblFrggXlUPQUvAc
         fNerH67cMROGNucPSyTozkHzu6DszUfCo70Ol+Agtclbaqmp2sRIBbqyaTY9FXE7sDcn
         csVA1G5aCMMVeCWYWogE/VUJaVHTwKMhC/rh/Nl7BTpyn8RTJL27HaUcc/h/Qw4ewkdo
         m7EAI85rIcA/Jdk6kBxJ+Q/GqxVFGKuWBfrAElyvGInPdRdMzHFlhPmJBHMgM8vfGIyd
         cRbg==
X-Forwarded-Encrypted: i=1; AJvYcCUojBX8+xlWNp/CMsnqDbtWHQYByvLjSfPsOCotGe+YV+9lqNyi9ZkPyiBo4409OomMU+UWMaCyFqIGLzMYa00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKVpXCAdBSze5lqoD+l3emq6ld+iaQSdQLZbskxm1yrvY9xGK
	2cwoiCSujVLSA7o2BkmQ4pH0m+40rkHGU4CBuON5ke9zIaVDx5BftDQxapgk
X-Gm-Gg: ASbGncsCM0v4ROoxVkINnGuMuucJQRbp3SZhxgzjt4nqnr8cFWF4NUgaJrwkdv9uR4P
	g8JOHoE1OEUiEmhGJSqXrYijaNqyyECT/708jy1RSbXGEh4fGGUZY7WIRIy1anI/AVn/jhjRgAy
	BYFbv4RftX9K05Siv0VIKOWezycA30yenCa7/Y/qsF33mDO6rMPGL7sEF3qUrTlojBq6NdKsRqY
	Y4efZWyauNvbmkG5ebhCzMD6029OSZAuV1YF3/38wOMR1fUDY74lSigUbb0Ev2WoqeyuH3IkOkP
	h6AdyZb3J25vqDoritwQlMHRpuUNRVoQN4EdbeRVlS676xZj653NcUXX0w==
X-Google-Smtp-Source: AGHT+IEmzpdRfroAIEPIL7+pwQe4f2ES9B0C6EZn6C+xpvOPqGSTIOstqonfdnt5BpA5MEdSGccDEw==
X-Received: by 2002:a05:6a00:84a:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-73426d78ecemr30572954b3a.16.1740513909595;
        Tue, 25 Feb 2025 12:05:09 -0800 (PST)
Received: from google.com ([2a00:79e0:2e52:7:2633:28b9:cd56:888c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81ecaasm1920426b3a.153.2025.02.25.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:05:08 -0800 (PST)
Date: Tue, 25 Feb 2025 12:05:04 -0800
From: Kevin Krakauer <krakauer@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/net: deflake GRO tests and fix return value
 and output
Message-ID: <Z74icGa4rlnNafoW@google.com>
References: <20250220170409.42cce424@kernel.org>
 <20250223151949.1886080-1-krakauer@google.com>
 <20250224124830.7c38608a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124830.7c38608a@kernel.org>

On Mon, Feb 24, 2025 at 12:48:30PM -0800, Jakub Kicinski wrote:
> With msec-long deferrals we'll flush due to jiffies change. At least
> that explains a bit. Could you maybe try lower timeouts than 1msec?
> Previously we'd just keep partially-completed packets in GRO for up 
> to 1msec, now we'll delay all packet processing for 1msec, that's a lot.

Results again with each test run 1000 times:

gro_flush_timeout=50us  napi_defer_hard_irqs=1 --> failed to GRO 0 times
gro_flush_timeout=100us napi_defer_hard_irqs=1 --> failed to GRO 0 times

gro_flush_timeout=50us  napi_defer_hard_irqs=0 --> failed to GRO 36 times
gro_flush_timeout=100us napi_defer_hard_irqs=0 --> failed to GRO 46 times

100us with 1 defer seems to work fine and is well below the duration of
a jiffy. So we'll usually be testing the "default" GRO path and only
occasionally the jiffy-update path. I'll make these the numbers in the
revised patch unless someone thinks otherwise.

