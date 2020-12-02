Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474BC2CC1B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgLBQIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 11:08:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53522 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgLBQIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 11:08:41 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2G7gd1016221
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 11:07:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C33DB420136; Wed,  2 Dec 2020 11:07:42 -0500 (EST)
Date:   Wed, 2 Dec 2020 11:07:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        elver@google.com, yzaikin@google.com, adilger.kernel@dilger.ca,
        Tim.Bird@sony.com, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
Message-ID: <20201202160742.GB390058@mit.edu>
References: <20201116054035.211498-1-98.arpi@gmail.com>
 <20201116054150.211562-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116054150.211562-1-98.arpi@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 16, 2020 at 11:11:50AM +0530, Arpitha Raghunandan wrote:
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
> 
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

