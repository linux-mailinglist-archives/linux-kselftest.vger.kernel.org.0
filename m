Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C15E428507
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 04:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhJKCMx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Oct 2021 22:12:53 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:37730 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhJKCMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Oct 2021 22:12:52 -0400
Received: from [172.16.66.209] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 06B4520222;
        Mon, 11 Oct 2021 10:10:43 +0800 (AWST)
Message-ID: <de7b75062fbc19824111685a9b8119545ee83e35.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when
 building as a module
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     David Gow <davidgow@google.com>
Cc:     Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Mon, 11 Oct 2021 10:10:43 +0800
In-Reply-To: <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com>
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
         <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
         <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
         <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

> In any case, thanks a lot -- this is awesome.

Oh neat, glad it's useful!

I'm happy to keep hacking on this if it's in a direction that makes
sense for kunit in general. As an approximate plan, I can fix the UML
breakages, then work on some resulting simplifications for tree-wide
initialisers (we'd no longer need the null-terminated arrays of suites
everywhere, for example).

Cheers,


Jeremy

