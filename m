Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8462F1CB410
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHPzF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 11:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgEHPzE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 11:55:04 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9657321473;
        Fri,  8 May 2020 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588953304;
        bh=hkoRcrZ1SxELIhpc5KMZCtx4k5hgispyhGBzWkKez14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sRj2GDoBI5l+vIFZbCyEibAI43TQEgdmsihDBxQFwzlVW8ziA1xwr2IAW1GX2vGXc
         2fQX3xDnfSXUihcW7KBrsdR7voDwS55DYyjVXWNKCfwB2skJzWgGDKJ4N59ifSK0Lt
         hLiuEOSsLCqaybSpuK8Eb2b4JnF+dsttZ2fzepDc=
Subject: Re: [PATCH] selftests/vm/keys: fix a broken reference at
 protection_keys.c
To:     Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <d478a2fc5d204691d0cac6e2b416f0e07a26d3d9.1588585390.git.mchehab+huawei@kernel.org>
 <bd55a74d-1305-9e23-94cd-37e59c11dfcd@intel.com>
 <43841ceb-f682-26ff-8b57-fed545759193@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5ad59d36-ee2d-a37c-cbaa-42c3071a03c0@kernel.org>
Date:   Fri, 8 May 2020 09:54:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <43841ceb-f682-26ff-8b57-fed545759193@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/20 8:38 AM, Sandipan Das wrote:
> 
> 
> On 04/05/20 7:40 pm, Dave Hansen wrote:
>> On 5/4/20 2:44 AM, Mauro Carvalho Chehab wrote:
>>> Changeset 1eecbcdca2bd ("docs: move protection-keys.rst to the core-api book")

checkpatch doesn't like this commit description.

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit 1eecbcdca2bd ("docs: move 
protection-keys.rst to the core-api book")'
#72:
Changeset 1eecbcdca2bd ("docs: move protection-keys.rst to the core-api 
book")

>>> from Jun 7, 2019 converted protection-keys.txt file to ReST.
>>>
>>> A recent change at protection_keys.c partially reverted such
>>> changeset, causing it to point to a non-existing file:
>>>
>>> 	- * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
>>> 	+ * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)
>>>
>>> It sounds to me that the changeset that introduced such change
>>> 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
>>> could also have other side effects, as it sounds that it was not
>>> generated against uptream code, but, instead, against a version
>>> older than Jun 7, 2019.
>>>
>>> Fixes: 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")

WARNING: Unknown commit id '4645e3563673', maybe rebased or not pulled?
#87:
Fixes: 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru 
to a generic name")

This commit didn't land in Linux 5.7-rc4 yet looks like. Probably in mm
or doc tree and has dependency on it?

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
