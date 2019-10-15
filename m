Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3106FD774E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfJONSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 09:18:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:16623 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbfJONSp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 09:18:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 06:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="208181089"
Received: from mcretu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.56.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Oct 2019 06:18:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Tim.Bird@sony.com, changbin.du@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions' to 'specific'
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191013055359.23312-1-changbin.du@gmail.com> <875zkrd7nq.fsf@intel.com> <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com> <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de> <20191015115439.GE32665@bombadil.infradead.org>
Date:   Tue, 15 Oct 2019 16:19:36 +0300
Message-ID: <8736fub0yf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Oct 2019, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
>> > My preference would be to use 'symbols'.  I tried to come up with something
>> > but 'symbols' is better than anything I came up with.
>> 
>> Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
>> imprecise as 'functions'.
>
> I suggested 'identifier' because that's the term used in the C spec (6.2.1):
>
> : An identifier can denote an object; a function; a tag or a member
> : of a structure, union, or enumeration; a typedef name; a label name;
> : a macro name; or a macro parameter.
>
> We don't allow documenting all those things separately, but it does cover
> all the things we do allow to be individually documented.

Agreed.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
