Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74A0EB19C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfJaNvL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 09:51:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52904 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJaNvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 09:51:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so6021550wmg.2;
        Thu, 31 Oct 2019 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gAclQFwXxT+EpCdR+7raEwTaxKHzgavsPREsM1zGn+U=;
        b=idnQhtYQ3TBs6KRPEkfaDxAhsWnSbcQiblhWd/rUqCaholJb+Y6Q4/pGjTG3wgXy1P
         40455Viwd3gxYt+PaByLrYdbujjRrwE6wSqw6ib1JZnsIJGSovtnxPn+I4tiL+vxp6ru
         aCdFGQpzKNpKMx6C4EPSylCqtT2fhgJ4FH2TNd4AP6XuSpXi3YKYPH946q3VOhrO5XhI
         KxSALsOS8wHCNu42BPwgvyYl1+Ju72i7yPUNb1V7wUce/jqdOtN0BFgyKHwRik2dFsGz
         n9e3eC840rv8hyhOlyIBR1W4IPf4ghXMi/9D/PSA4o51ERYxrDKAwDCk5ZfPR5Es1dku
         GbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gAclQFwXxT+EpCdR+7raEwTaxKHzgavsPREsM1zGn+U=;
        b=G5m4MW6w7cHfWpsOH8OzL5RYlFoLTXWnjOqsXAxTG6u/9ZQnV0xYQoa024G2JQYqGC
         caI+ENAMl1Sze1UGQW6pT7AIBVaweJkrwMFrQeqzuNPlG5U/nNALIxaGnNMWlhw1RNHF
         K5MJz0/LxezFF7iQLbxLcpAu3zGP46zXyK2fvnXbk7nyuk1I6g6oWZfoO/CAmxuszYiN
         blxWqY0l1T037unm2IPMbzOXmgMvsLVuhvZ1U68guZXNx6EJSEeiOrnhayuxhgGWe/lN
         I7DbwkwoFpmLPipts+2Q+cji9r06bjS8mp22FiQNkZrASM0Jf7jL2iaSei9zfAWjELZf
         ahqg==
X-Gm-Message-State: APjAAAX6//v0FQj3ZcEN+/5vhD7QjniplT/oeIp82u/zRAM8a4t5oGHl
        GN48E/IWvZweAgWkRx2E/5BigO3nmtQ=
X-Google-Smtp-Source: APXvYqznGvYQ+XQnAoy7o1i04CIKW2qqDDwcXhCWnjOonccojJ1bEGmlN+Ww8nI8BXSRkwxeB+pFOg==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr5185694wma.57.1572529866293;
        Thu, 31 Oct 2019 06:51:06 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id b62sm3541546wmc.13.2019.10.31.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 06:51:05 -0700 (PDT)
Date:   Thu, 31 Oct 2019 21:50:54 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191031135052.tl63uzhdgcpcqwj5@mail.google.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
 <20191024121940.1d6a64df@lwn.net>
 <87woctb9cj.fsf@intel.com>
 <20191025144802.uixg2crhw6h7gghq@mail.google.com>
 <87v9s99q9l.fsf@intel.com>
 <20191029003120.llve32crfw63ovpw@mail.google.com>
 <20191029020027.516a6bce@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029020027.516a6bce@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 29, 2019 at 02:00:27AM -0600, Jonathan Corbet wrote:
> On Tue, 29 Oct 2019 08:31:22 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Here python is different from C. Both empty string and None are False in python.
> > Note such condition is common in python.
> 
> Treating both as a False value is reasonably common.  Treating them
> elsewhere in the same code block as separate values is less
> so; that's the part I would prefer to avoid.
>
ok, please check update in v3.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
