Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73430D14A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJIQyD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 12:54:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730490AbfJIQyC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 12:54:02 -0400
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x99Grrwb017647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Oct 2019 12:53:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 05E5542045A; Wed,  9 Oct 2019 12:53:52 -0400 (EDT)
Date:   Wed, 9 Oct 2019 12:53:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v1] fs/ext4/inode-test: KUnit test for ext4 inode.
Message-ID: <20191009165352.GA13279@mit.edu>
References: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 08, 2019 at 07:42:05PM -0700, Iurii Zaikin wrote:
> Note: this patch is intended to be applied against kselftest/test branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> 
> KUnit tests for decoding extended 64 bit timestamps.

I'd suggest using "ext4: add kunit test for decoding extended
timestamps" as the one-line summary, and we probably don't need
anything else.

> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> ---
>  fs/ext4/Kconfig      |  12 +++
>  fs/ext4/Makefile     |   1 +
>  fs/ext4/inode-test.c | 217 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 fs/ext4/inode-test.c
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index cbb5ca830e57..72c26abbce4c 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -106,3 +106,15 @@ config EXT4_DEBUG
>    If you select Y here, then you will be able to turn on debugging
>    with a command such as:
>   echo 1 > /sys/module/ext4/parameters/mballoc_debug
> +
> +config EXT4_INODE_KUNIT_TEST
> + bool "KUnit test for ext4 inode"
> + depends on EXT4_FS
> + depends on KUNIT
> + help
> +  This builds the ext4 inode sysctl unit test, which runs on boot.
> +  Tests the encoding correctness of ext4 inode.
> +  For more information on KUnit and unit tests in general please refer
> +  to the KUnit documentation in Documentation/dev-tools/kunit/.

Should we perhaps just call the cofnig "EXT4_KUNIT_TESTS"?  Right now
the only thing we test is timestamp encoding/decoding, but later on
we'll be adding other other ext4 uninit tests --- and more ext4
encoding tests is not neceesarily where I would start, since the rest
are actually quite straightforward.

(The next set of uninit tests I'm interested in is the ext4's
extent_status tree, since that requires minimal amounts of test
mocks.)

So we might as well make the config name more general to begin with.

      	       	    	     	    - Ted
