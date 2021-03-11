Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671DE337EAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 21:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCKUF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 15:05:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:58151 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhCKUFT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 15:05:19 -0500
IronPort-SDR: XquBZnu7ATEmIQVLbQ1U5CdsHaHy8IQk2s7+N9ADE5dOTghvr1gi0a0o3a34+abuv+r0ECOxQO
 YGjW0Xgfys1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188828700"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188828700"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:05:19 -0800
IronPort-SDR: FbBl7vt7kRG6veBODarDsB6owtweSKVaX9+h//dt0YVjEZAl/r6yUr3KXsCzySdt6nLFYsX+T2
 3OzFsKxYCx8w==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="387131641"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:05:18 -0800
Date:   Thu, 11 Mar 2021 12:05:17 -0800
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
Message-ID: <20210311200517.GG203350@tassilo.jf.intel.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
 <20210307180541.GA17108@ubuntu>
 <20210307224927.GT472138@tassilo.jf.intel.com>
 <20210309184054.GA3058@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309184054.GA3058@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


<scenario that init will not be killed>

Thanks.

Okay but that means that the brute force attack can just continue
because the attacked daemon will be respawned?

You need some way to stop the respawning, otherwise the
mitigation doesn't work for daemons.


-Andi

