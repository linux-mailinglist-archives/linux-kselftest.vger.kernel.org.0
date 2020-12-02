Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C972CC19B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 17:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgLBQDO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 11:03:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52534 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726935AbgLBQDN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 11:03:13 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2G2FHk014005
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 11:02:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0AE36420136; Wed,  2 Dec 2020 11:02:15 -0500 (EST)
Date:   Wed, 2 Dec 2020 11:02:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
Message-ID: <20201202160214.GA390058@mit.edu>
References: <20201116054035.211498-1-98.arpi@gmail.com>
 <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
 <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
 <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 30, 2020 at 02:22:22PM -0800, 'Brendan Higgins' via KUnit Development wrote:
> 
> Looks good to me. I would definitely like to pick this up. But yeah,
> in order to pick up 2/2 we will need an ack from either Ted or Iurii.
> 
> Ted seems to be busy right now, so I think I will just ask Shuah to go
> ahead and pick this patch up by itself and we or Ted can pick up patch
> 2/2 later.

I have been paying attention to this patch series, but I had presumed
that this was much more of a kunit change than an ext4 change, and the
critical bits was a review of the kunit infrastructure.  I certainly
have no objection to changing the ext4 test to use the new
parameterized testing, and if you'd like me to give a quick review,
I'll take a quick look.  I assume, Brendan, that you've already tried
doing a compile and run test of the patch series, so I'm not going to
do that?

						- Ted
