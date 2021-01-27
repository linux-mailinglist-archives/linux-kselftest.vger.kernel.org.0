Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6678305C40
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Jan 2021 13:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhA0M5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Jan 2021 07:57:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:12258 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343568AbhA0MzA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Jan 2021 07:55:00 -0500
IronPort-SDR: 55rxYQ9yPQ7HosBR2wjBXraUeYRiAMpZfJmbVJduSvsvmyPfS1UrLpAhvDKu2sAFy5ru+9bIFV
 1pLNgYqZ9s5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167158593"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="167158593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 04:53:11 -0800
IronPort-SDR: +i2HBJGefcGdDW+EOEFWb77dhcquM48zyyIVYH/t2GLZ1wO/34Qmu8PatSj386vXSBQvTCZ4Uy
 PLD8kAXT/IoQ==
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="430090394"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 04:53:07 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Jan 2021 14:53:04 +0200
Date:   Wed, 27 Jan 2021 14:53:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [RFC 3/3] thunderbolt: build kunit tests without structleak
 plugin
Message-ID: <20210127125304.GD2542@lahna.fi.intel.com>
References: <20210125124533.101339-1-arnd@kernel.org>
 <20210125124533.101339-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125124533.101339-4-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Arnd,

On Mon, Jan 25, 2021 at 01:45:28PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The structleak plugin causes the stack frame size to grow immensely:
> 
> drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Turn it off in this file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

To me this is a reasonable work around so I can pick this up to
Thunderbolt tree if no objections.

Thanks BTW, for doing this. I got a report from buildbot some time ago
about the this but did not have time to figure out how to fix it :)
