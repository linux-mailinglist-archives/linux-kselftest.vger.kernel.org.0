Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196C629D71
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKOP3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKOP2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 10:28:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39C2E9DD;
        Tue, 15 Nov 2022 07:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F19D61830;
        Tue, 15 Nov 2022 15:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60711C433B5;
        Tue, 15 Nov 2022 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668526080;
        bh=vDhMwdEgWmFYBIGRGRWIfrJhEifHT3fM0Q6L4oFDo18=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=qldmv/rm0avaoa4CdEhMDRZz8/a5GjtTs7AJABfLeTp8tzlDmawVLqp6ANtZzYEOi
         qhN5CTKOUhR61gt7DHdaJ7T1U+TMs6oocD1CB7MSYrtQSXBqH7cLf6fEfHWv+NS6cr
         nrx++rN/N8P+204IKBLcSpMWzYAllmDGthpBZOijGU0D1ZohThRCeTY2x/fxsChsFi
         3JDIqyLIaf25sRgjYYWY3I33W6eSGTBitopZGxwqiLWG+DFoz50wzaJve+khiBVXIE
         CmQ3Jx6aZoWAcwuAQjMJZ7ojJMwbH4xWfyVackfocxNd01UqbZBancHGzyOns7xr1i
         MmHx/taBbMdnA==
Date:   Tue, 15 Nov 2022 16:27:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH hid v12 01/15] HID: fix I2C_HID not selected when
 I2C_HID_OF_ELAN is
In-Reply-To: <20221103155756.687789-2-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2211151627270.6045@cbobk.fhfr.pm>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com> <20221103155756.687789-2-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 3 Nov 2022, Benjamin Tissoires wrote:

> When I2C_HID_OF_ELAN is set, we need to turn on I2C_HID_CORE to
> ensure we get all the HID requirements.
> 
> Fixes: bd3cba00dcc6 ("HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new in v12

As this one has in principle nothing to do with the HID-BPF support, and 
is actually a functional fix, I've cherry-picked this one into 
hid.git#for-6.1/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs

