Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E113C16015C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2020 02:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgBPBaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Feb 2020 20:30:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36966 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgBPBaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Feb 2020 20:30:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so5310876plz.4
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2020 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H1J2XGmudHXtmp+DJfVLIIqWxd4GHWG0D55ayu8ofeI=;
        b=gFq89J3C6y2E3dC6eJosGCejVHswqtg68Tow44UbrH2gVrpogK7qFB1KHIIqqUr7bn
         tF6i1gknCrbwVMRuZQ5ME8rn/UmTXJDDfhHRV6pW2PIY5pqan+jFUw+/kb92UAgwLVbj
         T/G17QADHWbAVrR3b1QVTsvF3ed/aWsXDnw5zV2uSZHZk/45sRr34UPnEUrZgMEdy6J6
         YqeWVAyXZWILuihYlGoDPXdNP++ifAKU+tFKpgmi8EBlQR2AX2NbhCSBXI96xRW5tjuA
         ImAmKQCewP/SSbyC0hOD2KKx7/xtU+uyWnFN+4DYSnSZDjveEXzbpjxCsl1eW+3zXMKv
         iahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H1J2XGmudHXtmp+DJfVLIIqWxd4GHWG0D55ayu8ofeI=;
        b=TGlMZGtLvwc2INtHHPFHmwDwttd4csu2MoIaZq+kiUOMp1yjd9ex1xnZCQydRPIOdf
         /q6I/2t0YN/r0q6UVMXToX47WRCf6vqru9oCCoAoRYKp6Cdsko57jAA2m0cNJz0i2AkK
         cDSO/+t8DXzv5FPvaam2V63HQ6pFKtoA9v8fOD9QOsZj6IKCP2mTTuccwQ7JtMPap0py
         ocqAdni8oolBD9JSCoTYPvuhuy1Yll1q7Z/IZOMPYp5pJ9SIAd5VSJFSAErlU09DU9zJ
         L0E9+L9LN9RtscH203BXcH6qJkR1o/PiP9MYA4nefuWIyrTN5MQBuXhOi0TLTpGjFX9V
         mreg==
X-Gm-Message-State: APjAAAVXWQqOQaQVImbsYxyCsTkniYHUXrKla8c/POrVAEvgaWhLjjvC
        KYIFLE/tBWZavyQIkBhttSpY4g==
X-Google-Smtp-Source: APXvYqyGFRjjGux2Y1Zo0z/8WLWOp+BzYnoiWnfZ6OCKzLnyPcaJCc5ufv5eAEVQKL1cq60yEjgu4Q==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr9683676ple.226.1581816600814;
        Sat, 15 Feb 2020 17:30:00 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f3sm12207242pga.38.2020.02.15.17.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 17:30:00 -0800 (PST)
Date:   Sat, 15 Feb 2020 17:29:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 7/9] hugetlb: support file_region coalescing again
In-Reply-To: <20200211213128.73302-7-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2002151729470.244463@chino.kir.corp.google.com>
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-7-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 11 Feb 2020, Mina Almasry wrote:

> An earlier patch in this series disabled file_region coalescing in order
> to hang the hugetlb_cgroup uncharge info on the file_region entries.
> 
> This patch re-adds support for coalescing of file_region entries.
> Essentially everytime we add an entry, we call a recursive function that
> tries to coalesce the added region with the regions next to it. The
> worst case call depth for this function is 3: one to coalesce with the
> region next to it, one to coalesce to the region prev, and one to reach
> the base case.
> 
> This is an important performance optimization as private mappings add
> their entries page by page, and we could incur big performance costs for
> large mappings with lots of file_region entries in their resv_map.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: David Rientjes <rientjes@google.com>
