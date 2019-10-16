Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0564BD84A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 02:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfJPADk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 20:03:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35873 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfJPADk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 20:03:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so798157wmc.1;
        Tue, 15 Oct 2019 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+boKbPCJy6Y+QmEBbA2r6Sy5oF4Bkb5MuauoyykrQg=;
        b=o9s23SP7JEIeCegNEId+494t1oUADoPW/AaYLQCM9nW0UZY9VnFOmgJAKyfhJV+vfU
         SUM67QdQDD5jfkrS6zCFCJiY9HkKYL41XjA5rTppD9+Cn/Mf87TyIvcdt6TfoX8sLplC
         SHxLR2sjCen3SsmBsodriYKupoRWPzbRNr//tuLfLVxJH0dkiv7cW6XWTVlL49G3gBcZ
         TavTe8XoTdJDg3jnnbsW26uuFU4iPOE3ydfvc3pkAjt5zpmUMw2fBjHIwP8x1gnJzaeL
         L+xycGn81efQM6XCUoVgqn5ACf4ZVgvewcW3NfYREkAnQ18+p0G5cPrcTSgUX/Uk82Ay
         XvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+boKbPCJy6Y+QmEBbA2r6Sy5oF4Bkb5MuauoyykrQg=;
        b=Mb5VpJQ8wBE5KJyKwUGmeGdh2lyhIE05toSwx2ocPDBf4vCWWFA1h0AzlyUJ854gUJ
         5QPMXkY1wn05sC1tNCtSjBeWLT9ZDw2w7SUaD4vZGoSbcokAntFPVVwOJdA/DJm9hgAN
         tL8S8c+jwO8RNZQeNw0hji6Ufy1bTN9YPa8jzK4b6z5anCzaXQ2BQg5PqLJ2LhrQd/X0
         sKvNpYLKbAQBMUMACuQM1e1lh9kghPaTNID5gXFQ0ro2tmifGYUdm9V8dkfudneo/78g
         0FZvNP6axIMztXaQowCi281vrrDOK9fdGwcMmaJ/1LfAIoDHwK1EI9GCzboxykDDCbF7
         ZrfQ==
X-Gm-Message-State: APjAAAXIaWqjOWNiQNrl7scQes5ICv/6xHrx3xwgV5NnzK3yAD8egS+q
        j1mKJo8GRjN3zcd8j7jUg1Y=
X-Google-Smtp-Source: APXvYqyCj2CodWgBxqzJ6BnmheAkq7jFR2HRMpb748mzst4r2RhVtoYTg1jcyiHQDjd7jbTwZwftgw==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr807381wmj.93.1571184216877;
        Tue, 15 Oct 2019 17:03:36 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id q19sm47346920wra.89.2019.10.15.17.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 17:03:35 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:03:24 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, Tim.Bird@sony.com,
        jani.nikula@linux.intel.com, changbin.du@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191016000322.7dnuwvxqtdbg7clq@mail.google.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
 <20191015115439.GE32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 15, 2019 at 04:54:39AM -0700, Matthew Wilcox wrote:
> On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
> > > My preference would be to use 'symbols'.  I tried to come up with something
> > > but 'symbols' is better than anything I came up with.
> > 
> > Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
> > imprecise as 'functions'.
> 
> I suggested 'identifier' because that's the term used in the C spec (6.2.1):
> 
> : An identifier can denote an object; a function; a tag or a member
> : of a structure, union, or enumeration; a typedef name; a label name;
> : a macro name; or a macro parameter.
>
I also prefer this one now. I was looking for something like this. My original
idea is 'prototype', but that is only for function.

> We don't allow documenting all those things separately, but it does cover
> all the things we do allow to be individually documented.

-- 
Cheers,
Changbin Du
