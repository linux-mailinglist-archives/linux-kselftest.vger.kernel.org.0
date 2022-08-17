Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD054597184
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiHQOkQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbiHQOkA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 10:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CD72B62;
        Wed, 17 Aug 2022 07:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE270B81DE9;
        Wed, 17 Aug 2022 14:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C3EC433C1;
        Wed, 17 Aug 2022 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660747143;
        bh=H1/55EN0CNNUFKMWzDOU/nWySd6mb3zYs3Er1MLkWeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ/YUfhAl2Ua2sOsX8zm8+SzzLH/BPgYknTCUNxJ2+TVz2gjzxEOPGQZfY+fBdFbi
         qpXbQVwwpgP3HyW37XRz1X/VhQtX4MNdityW7oOiB+rmCjbzhvpKXukei8HiZo5f86
         nf5RM1IEecP6nBF7gRGxZ3hwtGGWAiv0m62yfObXszgrQyDS30td/+KMbcjx4UNgU0
         qZEv9xSuTyM114JAa00rcpPVCuWNmQmfDnDkYFEkRcCZF6RgBLDm01dCOqDx3w8+te
         RGYPLEjTJh1HplazTpEK0qccvOn6SJl+VTz1U7eGuDJGxL+ATmebvsdFn6zzT5SNCC
         q/1nB/he6DYWg==
Date:   Wed, 17 Aug 2022 17:38:59 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <Yvz9g1dx9qbbMXJf@kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 17, 2022 at 01:27:38AM +0000, Dhanraj, Vijay wrote:
> I think changing it to "int i" will cause a buffer overflow with
> edmm_size being 8GB.

Hmm.. 'i' iterates segments. Amd I missing something?

BR, Jarkko
