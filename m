Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AD1CEA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 20:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfENSIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 14:08:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfENSIS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 14:08:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so9521776pfo.11
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7yeeHOrqmC8a3wbdrT1dAENCvxmyZ37Vuhxj9vZ+GQw=;
        b=S0jZM4XE6V0spZEZFXmF3lzmN9RyUrDls3YW1YfceLrf1+atDdYu1cDy9C4umcia/3
         zscYDmEM5QFhJ0Lva8Sr/fBO7umd8310R/E4POlAM5wiB7jMzgSkP8SsOgHo4cuPtzqM
         j5f31ImygRcFRnpQwdS5IZIz9c6qvCbiaaZwXxiQnGCs4OmdaNEeAT0BXUQnQH/qgAa6
         HfIIFTZyV9zShckZnWJw1oElQyqVHLhJcgWa8zt0ufYs+8dsKUPv2sW1yVTo4jhRi601
         xWiCimgXoAgU8fIvE1m4CgoqiIh5RUVt2mEcjUAPFJsbkkmefrie+e0G224VchBEu3Gt
         Tibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7yeeHOrqmC8a3wbdrT1dAENCvxmyZ37Vuhxj9vZ+GQw=;
        b=E4wzlBURZLbgPjtnLXDTdVTH1g6fQ48dQ0jJnJKLWYxl8ix3EKA8CKV1GdpZh5LPo3
         /34H0Jb95PiSyyprGh0xpFSWVKHbCuAXg0k8rmkAOtFcU3+WywZhkCy6wvh3CjnHQ6IY
         P1qSz2KaLEwbctwwcSvxP9J+W8n6B8dmtzvghMZnic61qyLYCFC4osJXXYcmOc/zL0IV
         JoITKAtjLI5AkwvZoMgJOO/XtOXhMr8UK1OqeVvaVd0Zr+91YNooenb/h500VUl5GpE0
         T6h5kCRz4u9pW9jhfYdYbMbuawD9eMOjt+yBNWsEof6q3cIzC1kw3CqVRbKaqpW6P/85
         aoJw==
X-Gm-Message-State: APjAAAUIWE8+Q7wFC1z8zA3hdEJcNxqgsFNsQAVCsQpJLPmh1h0L3rhx
        P8G3Gq+TYO2CnrWsVryaYy3X5Q==
X-Google-Smtp-Source: APXvYqwwVSNPE5KOIRDKGnKoGzgoMRg2kvhAd8LSW436lA1eY3lipqpVLe11sNrtmgGOqBltRdlWXQ==
X-Received: by 2002:a65:534b:: with SMTP id w11mr39586352pgr.210.1557857296635;
        Tue, 14 May 2019 11:08:16 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id h18sm1568524pgv.38.2019.05.14.11.08.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 11:08:15 -0700 (PDT)
Date:   Tue, 14 May 2019 11:08:10 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v3 15/18] Documentation: kunit: add documentation for
 KUnit
Message-ID: <20190514180810.GA109557@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-16-brendanhiggins@google.com>
 <20190514073422.4287267c@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514073422.4287267c@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 14, 2019 at 07:34:22AM -0600, Jonathan Corbet wrote:
> On Mon, 13 May 2019 22:42:49 -0700
> Brendan Higgins <brendanhiggins@google.com> wrote:
> 
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> > 
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> > Changes Since Last Revision:
> >  - Addressed reference to incorrect number of sections, as per Randy's
> >    comment.
> >  - Make section underlines same length as the section title, as per
> >    Randy's comments.
> > ---
> >  Documentation/index.rst           |   1 +
> >  Documentation/kunit/api/index.rst |  16 +
> >  Documentation/kunit/api/test.rst  |  14 +
> >  Documentation/kunit/faq.rst       |  62 ++++
> >  Documentation/kunit/index.rst     |  79 ++++
> >  Documentation/kunit/start.rst     | 180 ++++++++++
> >  Documentation/kunit/usage.rst     | 575 ++++++++++++++++++++++++++++++
> 
> Certainly it's great to see all this documentation coming with this
> feature!
> 
> Naturally, though, I have one request: I'd rather not see this at the top
> level, which is more than crowded enough as it is.  Can this material
> please go into the development tools book, alongside the kselftest
> documentation?

Oh yeah, that seems like the obvious home for this in hindsight. Sorry
about that. Will fix in next revision!

Thanks!
