Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99068330297
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCGPTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 10:19:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:15647 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhCGPTV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 10:19:21 -0500
IronPort-SDR: rcwVF1zsDWWfeydQ/onW8Q1t7k1DFqOO6V6HjdFh7is5vmZLV2snJ1iMeExH8+32o6TV9mDP9Z
 8Nx8zFLfjWrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167172190"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167172190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 07:19:21 -0800
IronPort-SDR: VBQ85G5YYI/WVTz2b41mxqzXqF0+ssZMx7MQbDyrg3QsWTdTEwQLosgUq9Ov6r51Cb94QFKhyQ
 E0ZQT8/IMYEw==
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="409008502"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 07:19:21 -0800
Date:   Sun, 7 Mar 2021 07:19:20 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210307151920.GR472138@tassilo.jf.intel.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302183032.GA3049@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the late answer. I somehow missed your email earlier.

> As a mitigation method, all the offending tasks involved in the attack are
> killed. Or in other words, all the tasks that share the same statistics
> (statistics showing a fast crash rate) are killed.

So systemd will just restart the network daemon and then the attack works
again?

Or if it's a interactive login you log in again.

I think it might be useful even with these limitations, but it would
be good to spell out the limitations of the method more clearly.

I suspect to be useful it'll likely need some user space configuration
changes too.

-Andi
