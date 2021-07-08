Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB43C1982
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhGHTDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 15:03:06 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34327 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHTDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 15:03:04 -0400
Received: by mail-pf1-f170.google.com with SMTP id o201so1331304pfd.1;
        Thu, 08 Jul 2021 12:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qeD7rVhQ7jjqfjpaO+NzqFYuefbarzys8r49ePHEvE=;
        b=Hlwyz1Jbu9bvnAsZTgYvvsiP8/9m/xyWb5bbpFZB8nOC5SHD4tr7+IXsZ4ZTjYTIgF
         Ctq82s6PUEEws/9+D6HqNGowB0mfCmHcq6ZQsPNIMuDoIhxdq4NkSXvGRUoNSW5XKkSz
         vwvr5Kk+pce7uY8R6nk9Vh0GNiF9kjES6l3iCyHdTuDi2Gb2uUEtVGcSh6MBfbwsob+L
         Np7hsWF0ZpOYOE9YgPoOMLAS9wFwtfPPKSBAfW3sUN5EL81SvGFGpBjrF06G/x023QuX
         mRTvL45+wNB3D4QoQBKZ4IIgdn0fCavGN6C4LcpoaMnH4M0KTKSSDJDN7g3X8Ps5yr3+
         +SXw==
X-Gm-Message-State: AOAM532HHRw2Z6Pll/jnM9CVLBncqGf/dhVtXtep52OJhoS6wGynBrhS
        fXxLc3/4SW8wwKlLSEjEwu8=
X-Google-Smtp-Source: ABdhPJwmhMktMNnqPFrDeB5YW2+899VAsM6J5DRZeX+Qm+eBadmDbhqpmiZbp5JLB3Nvpl6pOKzB1g==
X-Received: by 2002:a62:e111:0:b029:31b:8150:38b4 with SMTP id q17-20020a62e1110000b029031b815038b4mr27709674pfh.48.1625770822360;
        Thu, 08 Jul 2021 12:00:22 -0700 (PDT)
Received: from garbanzo ([191.96.120.45])
        by smtp.gmail.com with ESMTPSA id m24sm4140157pgd.60.2021.07.08.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:00:21 -0700 (PDT)
Date:   Thu, 8 Jul 2021 12:00:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org, rafael@kernel.org,
        rgoldwyn@suse.com, kuno@frob.nl, fontana@sharpeleven.org,
        Ciaran.Farrell@suse.com, Christopher.DeNicolo@suse.com,
        corbet@lwn.net, linux@leemhuis.info, ast@kernel.org,
        andriin@fb.com, daniel@iogearbox.net, atenart@kernel.org,
        alobakin@pm.me, weiwan@google.com, ap420073@gmail.com,
        tj@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Message-ID: <20210708190016.v6pm4d2vy2fzizfz@garbanzo>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <20210708041446.GA17410@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708041446.GA17410@lst.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 08, 2021 at 06:14:46AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 07, 2021 at 11:43:08AM -0700, Luis Chamberlain wrote:
> > This adds the copyleft-next-0.3.1 SPDX tag and replaces existing
> > boilerplate with the tag.
> 
> Why do we need a random weirdo license in the kernel tree? 

Its already present in the kernel. This patch just adds the respective
SPDX license tag so we can remove the boiler plate.

> Is there
> any benefit?  If so it needs to be clearly spelled out.

The benefits are described in the first patch, I hope that's
clear enough. Let me know if its not!

  Luis
