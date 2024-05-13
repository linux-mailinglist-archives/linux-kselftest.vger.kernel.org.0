Return-Path: <linux-kselftest+bounces-10142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91848C458F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA5A1F21830
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89A1BDD0;
	Mon, 13 May 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNHmFR6J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758041AACA;
	Mon, 13 May 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619777; cv=none; b=CbiDaYYRPGhcKHN5dwpndEw+vbWXKCHNOP9848JYfnNtDctcwNSNxbvFeqZOAPwR+Tzev7fycZYuJGpiV5fasIFyV8mwLFZWYNuIaDcyGoeLlNhjRuTyq7ADbXPqDNPBL6wQWTikB0PfhOF0PLqLgTT8J7+12ZtHsrrOz4nwhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619777; c=relaxed/simple;
	bh=DudJ0M1t2xOJsupOhUhG4zVCuTfRl0L4ezlISHkVcho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW5YsYvCky4ywSsR072+8mYUmPaGEiq7r9XzUS8PJs9WXRlnd1ZWhgIkrKNAZvcSS5sNhymyD5UXne7rl0sV/djUgTiQR5JmqsuPjtpnP2fJAXOE7cVt6hcRRSGrvDHBAbG6S/VdJbyP/tuTuGMM4tOz0Ia3SOZemrjt0QXhC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNHmFR6J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ecddf96313so39548135ad.2;
        Mon, 13 May 2024 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715619776; x=1716224576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7/MyNyoBm5MjfWHxVQeY2+je7QIeNePW0nfv/5L5Eg=;
        b=iNHmFR6JwShIHjz1goVo/Q48CO/gztaxRHszXGK0DVDbzCPdo6Fo85T3kj9ta6PvOI
         /3JiBsXe2JHoHGVX2pAGiNdL5iW4r9C2MBHlMGsN0760tA3VrWOlGViVgppIJUrsaujq
         IAwMl3IytFaQZ71QvwyB4AvekJQbaRU5kPMVZXAifbDEzSw6K1nWo95hPjgnQVWHYC1I
         tqCr9SOC8KharvPLv0eO2XoPCJtKPK/7ny/V1N2CzvPTIRfiu5gkuoADOHfpOen/Dic6
         ZygLBeJAEOsCFK+KBk1k02LH5KOEZGAng7dRfaqNZNOJeiP5aNs84qfSV9/EEVBMC6A4
         sx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619776; x=1716224576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7/MyNyoBm5MjfWHxVQeY2+je7QIeNePW0nfv/5L5Eg=;
        b=ghBusnqF8V9ZGzlJwyPyJMQ4kLjRiGlwlpuNSdh/o++9wGiF+Gey/oeeLqSdKVEP/q
         QnMkq4kd3HTxvQCYuZZJ7J3Oz7lVZVETQmdzG5tCNWLExBN1M/ZxGlfzH3YRxDwJ2oCd
         Y1rY+AQEVT0PgezTA6odTCeNG1ATORC3DpZjEZRUSCZYuOs0reT0T02RmIQNysEPCq5U
         FgQkvMZvg2iSaAMbhIoX1sFyt0J9aL9A8iFfuUrol4qVBQ0cWvD7Eg1hvNijp+gNZLET
         UAidNy7byilFz+NcKlYl/rlHFxDjHff+f6WeeL0YaNrE0IzWxUrDHk/nVJTjhAQKCXQe
         F5bg==
X-Forwarded-Encrypted: i=1; AJvYcCVrhpzgNY8KvkJMXX4UaEsvBpve1XpreHn2OVk1f9D7TlF2I5KT5Nr93afHsYgloW7g7/Que8dWcopYT2nYv7ALe0QJpwgH5du6M7dtYjUUpMTQjZC4Nd69eje/PX3VBKCEdd2rbyMwqeX7D5YENnxgv2pKDf9VBo7zsgfeFV4Jb0U7OV4q1c44MTIN44IGrxjVfIlxd6+Ktgt23LupbgEnVQFrVRpdZA3ozgrYiha2qcpvf0gAYGjxmV6jjxZkqETvre5W0vVkvlQeaHc2mNVLtcO/yPfcT/qkeQ==
X-Gm-Message-State: AOJu0Yzvq+HysE8Tm+eUClf5Ish+57rOQWzClvRYysvrFdL+pFLhDB+/
	0jRiLcG/oC6UefWO8Rhk30bW6C8saY/7i7fIuQ/ji9u3NRa7HXh0
X-Google-Smtp-Source: AGHT+IHwOZA/yfEnvU1uj/wTKNnpTSmBPcCl0ixyY9k7PieEC1uOAPdzdzFf5e1FfRz7aoujiXiBYA==
X-Received: by 2002:a17:902:e945:b0:1eb:77ed:8fba with SMTP id d9443c01a7336-1ef43d1242dmr182253905ad.17.1715619775677;
        Mon, 13 May 2024 10:02:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30b17sm81794325ad.143.2024.05.13.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:02:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 May 2024 07:02:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
Message-ID: <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-9-edliaw@google.com>

On Fri, May 10, 2024 at 12:06:25AM +0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

