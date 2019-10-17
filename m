Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB05DAD8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfJQM4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 08:56:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34029 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729124AbfJQM4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 08:56:14 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HCtrJo003613
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:55:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4B61F420458; Thu, 17 Oct 2019 08:55:53 -0400 (EDT)
Date:   Thu, 17 Oct 2019 08:55:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kselftest@vger.kernel.org, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, adilger.kernel@dilger.ca,
        Tim.Bird@sony.com, kunit-dev@googlegroups.com,
        brendanhiggins@google.com
Subject: Re: [PATCH linux-kselftest/test v5] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191017125553.GE25548@mit.edu>
References: <20191016205820.164985-1-yzaikin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016205820.164985-1-yzaikin@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 01:58:20PM -0700, Iurii Zaikin wrote:
> KUnit tests for decoding extended 64 bit timestamps
> that verify the seconds part of [a/c/m]
> timestamps in ext4 inode structs are decoded correctly.
> KUnit tests, which run on boot and output
> the results to the debug log in TAP format (http://testanything.org/).
> are only useful for kernel devs running KUnit test harness. Not for
> inclusion into a production build.
> Test data is derived from the table under
> Documentation/filesystems/ext4/inodes.rst Inode Timestamps.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Minor nit.  The above commit description would look nicer when looked
at in "git log" when formatted as follows:

--- cut here ---

KUnit tests for decoding extended 64 bit timestamps that verify the
seconds part of [a/c/m] timestamps in ext4 inode structs are decoded
correctly.

KUnit tests, which run on boot and output the results to the debug log
in TAP format (http://testanything.org/) are only useful for kernel
devs running KUnit test harness and are not for inclusion into a
production build.

Test data is derived from the table in the Inode Timestamps section of
Documentation/filesystems/ext4/inodes.rst.

--- cut here ---

					- Ted

