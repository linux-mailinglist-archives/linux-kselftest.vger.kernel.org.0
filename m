Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97982D8512
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 02:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbfJPAs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 20:48:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJPAs2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 20:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pf6bbQYx9hUE+6rFYONnUuY9TK+2idQNGK21XGkY2xo=; b=qU7sjU5uXXip0NogETsugUAi3
        jtRE/3LcBLi9RdoLLx/XlPfCCqP/SEyUzVoQs8WqvIypx8a18jDctjkK4Re6BQG2NHTAYVe2clHx9
        Fc3+P2BkHiuODGY67O+nE61aVcc/8GpDa/jzNwRrmBaE2id/NXw+dKOwpSr6xQnMsQ4fuePOFe+js
        JIH8ZaatXc+A7TE44A1jvUJ6kUvX7Z+zadosMUcWzpR9cy44tC5hgJou/w2EXK7tpk4l7WdxUdnN+
        jZ8v5qs2XXayMAz4jgQI/jbaEXemK0icN8biguipxmOtXSmNRCQ8+4zKpkdeeh7JWzTQO0Suarzpb
        TMB4py35Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKXUD-0005ri-Tc; Wed, 16 Oct 2019 00:48:21 +0000
Date:   Tue, 15 Oct 2019 17:48:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, Tim.Bird@sony.com,
        jani.nikula@linux.intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191016004821.GI32665@bombadil.infradead.org>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
 <20191015115439.GE32665@bombadil.infradead.org>
 <20191016000322.7dnuwvxqtdbg7clq@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016000322.7dnuwvxqtdbg7clq@mail.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 08:03:24AM +0800, Changbin Du wrote:
> On Tue, Oct 15, 2019 at 04:54:39AM -0700, Matthew Wilcox wrote:
> > On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
> > > > My preference would be to use 'symbols'.  I tried to come up with something
> > > > but 'symbols' is better than anything I came up with.
> > > 
> > > Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
> > > imprecise as 'functions'.
> > 
> > I suggested 'identifier' because that's the term used in the C spec (6.2.1):
> > 
> > : An identifier can denote an object; a function; a tag or a member
> > : of a structure, union, or enumeration; a typedef name; a label name;
> > : a macro name; or a macro parameter.
>
> I also prefer this one now. I was looking for something like this. My original
> idea is 'prototype', but that is only for function.

We could also go with 'declaration' or 'definition'.  But I prefer
'identifier'.
