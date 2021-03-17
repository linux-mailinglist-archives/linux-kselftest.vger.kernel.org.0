Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843DD33F885
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 19:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCQSyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhCQSyg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 14:54:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA5C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 11:54:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 205so152346pgh.9
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yv6zPM7pUlq8ZRYfu9+Rm67Low/6QrEMjW8OfG4+8cQ=;
        b=YFzn3VVUJSbVDNgya8SNZeD4soOBKyMydCL4WfX9JLgKAGcfPgt/aIcDTUWB/DMmc6
         hindDnCjjTtYgkCfZ+KXo5diSGJxleE1YtRJK+/7Q23nr0XIbd9Ni1v0vgcZNTyrQU3y
         Enay3gzr5WWE51j1Nrs205Yv4P7XzGjaZICkqoRnu/iw/hceqlXYlj5K23nBd/U3slHf
         vy7zlUno14BwZIxHXhAiknnJlSOc1pdsdXh2y+glgXN+xx5yqKF0hUPqVwp+o05jGcig
         DCWgUYoH/778U6gfZE03F9doo8KuTyeJc3W5sRSaITbezPXILJilLk1A8PfLLY0xwQ53
         JohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yv6zPM7pUlq8ZRYfu9+Rm67Low/6QrEMjW8OfG4+8cQ=;
        b=tuVB0FBHEz4C270C5lN3n0csVRz9Rjd0JzjGOE1B+j3tngd1ahsZ1TfioEdVBy88XU
         nV1J1yiJjIRgwK5xW8LetxKj1s89zxhgq34V/1IMUEFPh+PEFYkCPnILI50VkiubJFel
         20DMiPjPBJdw0YV+yBPpb+yW/FV18TqKfGAaZrlj2HU6hQ9MPj+uWRsl3ZFbH3CVDU27
         X5lyymdyi2gGXIRxtXxRu7LOeQJqoGZXH4bO5OP2PU3C6dWh5pokTbrTUGTd6OBTTfRC
         exQfnVaT/7/Y6INNRuZ7ZLhAA3ZPvmplBxFWIcNYrr5txfKV1I04XvE5m2uJS0felKXh
         fWyg==
X-Gm-Message-State: AOAM5331ojNeES5vOzi8OdOSxCBeVQqENE+Yz74IPzi8FaSyvBP9g9c2
        o2DQ7otM6hkibn2JwrcEAcUO5g==
X-Google-Smtp-Source: ABdhPJwtjoKr8p+TtaWdwcd66x+jRrRVFgK2czmTEOtkzs9BcIrzlnTGp10l6glE3lYClcQfSDKoNw==
X-Received: by 2002:a62:1c8f:0:b029:209:7eb2:748f with SMTP id c137-20020a621c8f0000b02902097eb2748fmr477175pfc.79.1616007276167;
        Wed, 17 Mar 2021 11:54:36 -0700 (PDT)
Received: from [2620:15c:17:3:b56a:51db:a0a1:259f] ([2620:15c:17:3:b56a:51db:a0a1:259f])
        by smtp.gmail.com with ESMTPSA id t80sm2834084pgb.78.2021.03.17.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:54:35 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:54:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Oliver Glitta <glittao@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] slub: remove resiliency_test() function
In-Reply-To: <20210316124118.6874-2-glittao@gmail.com>
Message-ID: <398a728-dc1c-5089-5578-7af596d616ac@google.com>
References: <20210316124118.6874-1-glittao@gmail.com> <20210316124118.6874-2-glittao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 16 Mar 2021, glittao@gmail.com wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> Function resiliency_test() is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it.
> 
> This function is replaced with kselftest for SLUB added
> by the previous patch "selftests: add a kselftest for SLUB
> debugging functionality".
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Very nice!

Acked-by: David Rientjes <rientjes@google.com>
