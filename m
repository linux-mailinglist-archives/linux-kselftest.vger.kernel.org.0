Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D046D75A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfJOLyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 07:54:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfJOLyp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0yszEpJzojsv0U117iSsMG8HSxDkuZTGjoLlQ1g6Cro=; b=H2QiGrYjU+ubokt8xpeZfhmc4
        KeJqoyW8uxg7q1ISBlPkeTP2VdHeNdFTEjfM200kGher4lLa4FDZstL8YRJD8ekvVwvsmb0Xh9MA/
        lfFABlsn9oxUQAauCLzlpFOdRUSbEbEftAcVJJaMGJY9NIPHKq6QjSrP6QslqqBxQ3eLaFQdzC3DX
        TIla8pTIh8VTxkbhj7ewvknq0SzA4BjENLyfZTNdx3ia+LGoTRLtZYCdz0cbkHhiqHgzceQQAS/CK
        Ds/hLOlmUytSUF8O1f0IFiZGzOvwnZuONgSdBd4omuLOkIVrqAZm05F0lAxgbTylf8FsZGeFd7LZF
        KVLvVEaeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKLPT-0005JE-TQ; Tue, 15 Oct 2019 11:54:39 +0000
Date:   Tue, 15 Oct 2019 04:54:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Tim.Bird@sony.com, jani.nikula@linux.intel.com,
        changbin.du@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191015115439.GE32665@bombadil.infradead.org>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
 <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
> > My preference would be to use 'symbols'.  I tried to come up with something
> > but 'symbols' is better than anything I came up with.
> 
> Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
> imprecise as 'functions'.

I suggested 'identifier' because that's the term used in the C spec (6.2.1):

: An identifier can denote an object; a function; a tag or a member
: of a structure, union, or enumeration; a typedef name; a label name;
: a macro name; or a macro parameter.

We don't allow documenting all those things separately, but it does cover
all the things we do allow to be individually documented.
