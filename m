Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48218629D97
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiKOPc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 10:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiKOPc6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 10:32:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A57273D;
        Tue, 15 Nov 2022 07:32:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3424A6186A;
        Tue, 15 Nov 2022 15:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85459C433C1;
        Tue, 15 Nov 2022 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668526376;
        bh=1L1PU7LcHMQLmP0fJq+V++VPtvtxdQUZkoNlMGwb9ak=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vRNceK0H3tC4sH60FIUi3KHtxLfKL2+LlqanFddHdF0qPXoEuTLRIc+/jPZcnPbGk
         Sa+DKJEqt8k6gL3fB8fuPq4lEk/xKDhK9oboCgkFrj+d8+dDwtvbld9VQVD/Kque37
         UGHbwcpfFe6VJ/Up0MDBKzUojO/m7YYPPxmaVsneLaWfgLN9+8JkNTsiNSgkqyfkIQ
         y8lG7JU5lOZ9uBhuCvCMEVAgu/plH0LNibtWTSiTodcDNjmUUd/48UjG214HX1Ymvd
         ZyyEoxH1SdjHzgQx75l26nb5TCMu8qsQcSBkUxDfyvDUSmT5Zvq7ZkYJ/wJzP1ljJR
         VnkyHbjxKfeLg==
Date:   Tue, 15 Nov 2022 16:32:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH hid v12 00/15] Introduce eBPF support for HID devices
In-Reply-To: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2211151631060.6045@cbobk.fhfr.pm>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
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

> Hi,
> 
> and here comes the v12 of the HID-BPF series.
> 
> Again, for a full explanation of HID-BPF, please refer to the last patch
> in this series (15/15).
> 
> This revision contains most notably few fixes from the various kernel CI
> bots. I also took Alexei's review into account, and we do not pollute
> tools/include with useless hid headers.
> 
> I also removed most of the last checkpatch complains about adding
> external kfunc declarations in C files. And this led me to also show in
> samples/ how we can link together 2 BPF object files. Impressive how
> easy it is :)
> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (15):
>   HID: fix I2C_HID not selected when I2C_HID_OF_ELAN is
>   HID: Kconfig: split HID support and hid-core compilation
>   HID: initial BPF implementation
>   selftests: add tests for the HID-bpf initial implementation
>   HID: bpf jmp table: simplify the logic of cleaning up programs
>   HID: bpf: allocate data memory for device_event BPF programs
>   selftests/hid: add test to change the report size
>   HID: bpf: introduce hid_hw_request()
>   selftests/hid: add tests for bpf_hid_hw_request
>   HID: bpf: allow to change the report descriptor
>   selftests/hid: add report descriptor fixup tests
>   selftests/hid: Add a test for BPF_F_INSERT_HEAD
>   samples/hid: add new hid BPF example
>   samples/hid: add Surface Dial example
>   Documentation: add HID-BPF docs

This (apart from the first patch, which I've carved out into the fixes 
branch) is now in hid.git#for-6.2/hid-bpf

Thanks a lot for all the effort invested into this, Benjamin!

-- 
Jiri Kosina
SUSE Labs

