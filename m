Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE21C104050
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfKTQIO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 11:08:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfKTQIN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 11:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wl1O4ZSZrpVG0P8VIwY3iEyKaXlo821ZggeTRbWUELA=; b=V5xF6i7roVMaqz3GF/iZucket
        36rH3ujx1EHYAjW0OxxAfKrQRkWaX4gp9393H/qNSVzo9ZnM6IB2YiDz1whmREcsaTMhoqmICDQ0j
        5sVkO+EgBj0704WH4qn5gKzw4A5qC51rgzoZUYLZs3tfqaNVRUZJTS3bLg5VnqnhO+UDsH626xJeT
        JRMO1b6r9b7F1tL+UqFtMuU1KxabMChYIQHyz/cARUK02dv44v6OxMBWNfCfbXa8aXvZqeT/wuxui
        zGOqq+5+BMXVnY6ziHK253eCoukMRbhBTdVvGZ9qFkB76JJpxdu/Al1JGKuw+B23OFS/EfPyQPHOp
        TrNdCYgOw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXSWa-0004k0-Ra; Wed, 20 Nov 2019 16:08:12 +0000
Subject: Re: [PATCH linux-kselftest/test v3] Documentation: kunit: add
 documentation for kunit_tool
To:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20191119003120.154041-1-brendanhiggins@google.com>
 <4a3aada5-fe8f-9c82-dfd4-0494acf59334@infradead.org>
 <CAFd5g47+3TN4pOdeM0YmJpMP2uKnpJYUY_OXmqmZEn8OcVz6ow@mail.gmail.com>
 <20191120063219.1ad15b68@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2ba78e72-22e8-1c5e-103e-78eb892fb2cd@infradead.org>
Date:   Wed, 20 Nov 2019 08:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120063219.1ad15b68@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/20/19 5:32 AM, Jonathan Corbet wrote:
> On Tue, 19 Nov 2019 17:14:20 -0800
> Brendan Higgins <brendanhiggins@google.com> wrote:
> 
>> On Tue, Nov 19, 2019 at 4:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 11/18/19 4:31 PM, Brendan Higgins wrote:  
>>>> +How do I use kunit_tool?
>>>> +=================================  
>>>
>>> Hi,
>>> I haven't tested this, but Sphinx (or some doc tool) usually complains if the
>>> underline length is not the same as the header text length.  (I.e., use fewer
>>> = signs above.)  
>>
>> Hmmm...Sphinx and checkpatch didn't complain. I wonder if it is a
>> different script, or maybe I have to use a particular option with
>> Sphinx.
> 
> Sphinx wants the underline to be at least as long as the subheading text
> above; it's entirely happy if it's longer, though.

oh. thanks for the info.

-- 
~Randy

