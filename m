Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D98D84AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 02:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfJPAKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 20:10:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfJPAKl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 20:10:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so25826524wrq.10;
        Tue, 15 Oct 2019 17:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j69av0w9tOIcJjV3c32pq0GcgeoBfayplij6V6SpYU0=;
        b=bgHjvrc0BYjeuZcUXC0kki5/TiWu4OdYD3WS+IpNJ+KYIbdDqej8OzgPunn6eiq91H
         OVKWlynTXlxTOt1VCwiXBh1APyD/FWjLDlcYaGgSusW42XL2IXuu2oZG7QuhsPUOmW0O
         95lVXtXQ1Jslh1IHfl8pkUkCaYNDRlRsb2Fi3r2KaCwsl87MeICsp4TtZZqNEGq7zZln
         FJJ5kJoWgm0EvynFElArkJp66uIptrD/WBESQdxVJCI2TMg1diIHTlWE9T4X/+7V6GMp
         Ibss60H57X7xrP+slUD20AfBhGc05pxATFFFpiR8kSbgiQKPhQgiHBNBGW4gx0B0n47S
         gBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j69av0w9tOIcJjV3c32pq0GcgeoBfayplij6V6SpYU0=;
        b=rlhHUw6MTGnm2KT/vIwR1qd3NVhvKcknVRS1CuDfrhjcYix6aZEycOiQQ7KOA6hLAs
         JowzljdVwwYMgvbj1513IOrKXlEdD7UOKLLZerH7V0UIJ6rxG8NjGz4tdT2jRnIgH73N
         9DPSqdj6zlJxMO0xXfbUs+XZ4qJLHeApngIO3sHltz17xYs66k+88Xfyyq2Sgp1etWcC
         9gkIu8Vf9mJoyE+Qkjfe3uN3SCGWehXMuspnLBfKon2kiJDM4sDZNN03KxZq8NKq1bfh
         m983O3bcTPxYAMBQBgEerfatHBmILpy3EfzF8hQnHefRzgJBPYzCQXWbzxaOXAuEemr0
         wubg==
X-Gm-Message-State: APjAAAUdRUsv07AemKtDuJIQqX0F/oCDcZxdiVoW5XvwazfwCrMXbVNI
        XXSp2EKyNuq+446gr7vRmfAlOrI5y0o=
X-Google-Smtp-Source: APXvYqx9didLD4puGKS0MiDLXNZLOo8iIpQ3jo9nSKlc8SDSZHdSY8l1HBE2hD8vMB9qGmzlwoOa+A==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr44289wru.179.1571184638558;
        Tue, 15 Oct 2019 17:10:38 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id y5sm779614wma.14.2019.10.15.17.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 17:10:37 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:10:28 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191016001026.wa4hvc2pgyij2b4c@mail.google.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <20191015122726.7e12f551@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015122726.7e12f551@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 15, 2019 at 12:27:26PM -0600, Jonathan Corbet wrote:
> On Sun, 13 Oct 2019 13:53:59 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The 'functions' directive is not only for functions, but also works for
> > structs/unions. So the name is misleading. This patch renames it to
> > 'specific', so now we have export/internal/specific directives to limit
> > the functions/types to be included in documentation. Meanwhile we improved
> > the warning message.
> 
> I agree with the others that "specific" doesn't really make things
> better.  "Interfaces" maybe; otherwise we could go for something like
> "filter" or "select".
>
Jonathan, How about 'identifier' suggested by Matthew as it is mentioned in Then
C spec?

> Paint mine green :)
> 
> Whatever we end up with, I think it should be added as a synonym for
> "functions".  Then the various selectors that are actually pulling out
> docs for functions could be changed at leisure - or not at all.  I'd
> rather not see a big patch changing everything at once.
>
Sure, I'll make 'functions' deprecated and as an alias to our new directive name.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
