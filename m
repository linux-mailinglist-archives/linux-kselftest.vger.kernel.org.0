Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC440619583
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 12:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKDLls (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDLlr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 07:41:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4BF12760;
        Fri,  4 Nov 2022 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667562107; x=1699098107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SlT5UwsKk+Qh3q4aaxeOm1yda/xai3OJXLkLJpRzhzY=;
  b=f9Oh6hQTzH5YtXFXUqJOIiWHn8DFYNMLRDXQDEpg5NX5JYEeurBxw6Jh
   jvWp3yPYcabdLbaShx3XfsWmaX15jQlFOYfZ2Pp3+mpDrvS5uaqbiCTId
   7xRF1SpuDdUe33HZrybBaMRqnTZKs2S623T7i0WiPqMkEnluPcGlOLBJp
   1f0HSzcFdO8KyAPmcatE35l/ZqJbLHzd1WKWauxaLx09Ob9c2wA0aA+dt
   Bh57VkhiNnf2EcK8U7OriIc5zeGnBwYpvf1aCuV78rS3lZjdC6TYVAQga
   O2/t7UAdomoxSl4BeAKDXS4tNWZglr2cCEtNL9VCYuxlIZCccNDpYPcuS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396247153"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="396247153"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 04:41:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964319149"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="964319149"
Received: from ataghour-mobl.ger.corp.intel.com (HELO [10.251.217.193]) ([10.251.217.193])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 04:41:44 -0700
Message-ID: <be549b74-426d-b7a4-1493-73709936638e@linux.intel.com>
Date:   Fri, 4 Nov 2022 13:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH hid v11 00/14] Introduce eBPF support for HID devices
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Benjamin,

Tested this on top of 6.1-rc1 against my HID-USI work, appears to be 
good. Also tried out the HID selftests, and they pass, so for the whole 
series:

Tested-by: Tero Kristo <tero.kristo@linux.intel.com>

On 25/10/2022 12:34, Benjamin Tissoires wrote:
> Hi,
>
> and here comes the v11 of the HID-BPF series.
>
> Again, for a full explanation of HID-BPF, please refer to the last patch
> in this series (14/14).
>
> Now that the bpf-core changes are all merged in v6.1, it is
> time to have that series entirely relying on HID, so it can get
> merged into the HID tree.
>
> Compared to v10, the most notable change is in the selftests and the
> samples: they are now namespaced into hid, not bpf.
>
> This means that HID-BPF has no more conflicts with the bpf tree.
>
> One other interesting change is in patch 4/14. I managed to reduce
> the scope of the embedded bpf programs, by tricking the refcount.
> I am planning on submitting an RFC for embedding those changes in
> bpf core (a map that doesn't increment refcount and a cleanup mechanism)
> but this can come as a later improvement.
> This new kind of maps and mechanisms might also be useful for other
> subsystems.
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (14):
>    HID: Kconfig: split HID support and hid-core compilation
>    HID: initial BPF implementation
>    selftests: add tests for the HID-bpf initial implementation
>    HID: bpf jmp table: simplify the logic of cleaning up programs
>    HID: bpf: allocate data memory for device_event BPF programs
>    selftests/hid: add test to change the report size
>    HID: bpf: introduce hid_hw_request()
>    selftests/hid: add tests for bpf_hid_hw_request
>    HID: bpf: allow to change the report descriptor
>    selftests/hid: add report descriptor fixup tests
>    selftests/hid: Add a test for BPF_F_INSERT_HEAD
>    samples/hid: add new hid BPF example
>    samples/hid: add Surface Dial example
>    Documentation: add HID-BPF docs
>
>   Documentation/hid/hid-bpf.rst                 | 513 +++++++++++
>   Documentation/hid/index.rst                   |   1 +
>   MAINTAINERS                                   |   3 +
>   drivers/Makefile                              |   2 +-
>   drivers/hid/Kconfig                           |  20 +-
>   drivers/hid/Makefile                          |   2 +
>   drivers/hid/bpf/Kconfig                       |  17 +
>   drivers/hid/bpf/Makefile                      |  11 +
>   drivers/hid/bpf/entrypoints/Makefile          |  93 ++
>   drivers/hid/bpf/entrypoints/README            |   4 +
>   drivers/hid/bpf/entrypoints/entrypoints.bpf.c |  34 +
>   .../hid/bpf/entrypoints/entrypoints.lskel.h   | 368 ++++++++
>   drivers/hid/bpf/hid_bpf_dispatch.c            | 526 +++++++++++
>   drivers/hid/bpf/hid_bpf_dispatch.h            |  28 +
>   drivers/hid/bpf/hid_bpf_jmp_table.c           | 572 ++++++++++++
>   drivers/hid/hid-core.c                        |  32 +-
>   include/linux/hid.h                           |   5 +
>   include/linux/hid_bpf.h                       | 148 +++
>   include/uapi/linux/hid_bpf.h                  |  25 +
>   samples/hid/.gitignore                        |   8 +
>   samples/hid/Makefile                          | 246 +++++
>   samples/hid/Makefile.target                   |  75 ++
>   samples/hid/hid_mouse.bpf.c                   | 134 +++
>   samples/hid/hid_mouse.c                       | 160 ++++
>   samples/hid/hid_surface_dial.bpf.c            | 161 ++++
>   samples/hid/hid_surface_dial.c                | 231 +++++
>   tools/include/uapi/linux/hid.h                |  62 ++
>   tools/include/uapi/linux/hid_bpf.h            |  25 +
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/hid/.gitignore        |   4 +
>   tools/testing/selftests/hid/Makefile          | 242 +++++
>   tools/testing/selftests/hid/config            |  20 +
>   tools/testing/selftests/hid/hid_bpf.c         | 846 ++++++++++++++++++
>   tools/testing/selftests/hid/progs/hid.c       | 206 +++++
>   34 files changed, 4815 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/hid/hid-bpf.rst
>   create mode 100644 drivers/hid/bpf/Kconfig
>   create mode 100644 drivers/hid/bpf/Makefile
>   create mode 100644 drivers/hid/bpf/entrypoints/Makefile
>   create mode 100644 drivers/hid/bpf/entrypoints/README
>   create mode 100644 drivers/hid/bpf/entrypoints/entrypoints.bpf.c
>   create mode 100644 drivers/hid/bpf/entrypoints/entrypoints.lskel.h
>   create mode 100644 drivers/hid/bpf/hid_bpf_dispatch.c
>   create mode 100644 drivers/hid/bpf/hid_bpf_dispatch.h
>   create mode 100644 drivers/hid/bpf/hid_bpf_jmp_table.c
>   create mode 100644 include/linux/hid_bpf.h
>   create mode 100644 include/uapi/linux/hid_bpf.h
>   create mode 100644 samples/hid/.gitignore
>   create mode 100644 samples/hid/Makefile
>   create mode 100644 samples/hid/Makefile.target
>   create mode 100644 samples/hid/hid_mouse.bpf.c
>   create mode 100644 samples/hid/hid_mouse.c
>   create mode 100644 samples/hid/hid_surface_dial.bpf.c
>   create mode 100644 samples/hid/hid_surface_dial.c
>   create mode 100644 tools/include/uapi/linux/hid.h
>   create mode 100644 tools/include/uapi/linux/hid_bpf.h
>   create mode 100644 tools/testing/selftests/hid/.gitignore
>   create mode 100644 tools/testing/selftests/hid/Makefile
>   create mode 100644 tools/testing/selftests/hid/config
>   create mode 100644 tools/testing/selftests/hid/hid_bpf.c
>   create mode 100644 tools/testing/selftests/hid/progs/hid.c
>
