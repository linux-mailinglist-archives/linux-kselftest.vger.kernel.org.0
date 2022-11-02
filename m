Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E15616276
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 13:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKBMLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBMLu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 08:11:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819B2339E;
        Wed,  2 Nov 2022 05:11:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j15so24241338wrq.3;
        Wed, 02 Nov 2022 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IkJAPMWkO5FOeNL3Mj+9WKsIqTWMXPw/hrooudOQns=;
        b=PmL5Pde9zKOoDZ/SSJGPGWD4UAwpixZI2QmGylJGefMPo5sAgFsdn7vRx5AlqIdZ+W
         gKBjuH/qb8cj8IPg5bwx5G3HO7eJRDav6bjvsEzcnH+RjqjHXWanATiFUuRBt+QjEqIV
         +NzI/OhtDw1eF6F43JCdqCtAqaL3NmnFQDN+edYA5CReEvJT/rpzXQGoqnkVVfZEp9oh
         DU3QSN3ZYHNDrfb4nFxfBaot4Eszq4Rf62UWkMbmk/xpAWaNzQdNhTKZynJf1jx7CZ22
         dGQ3DtLnMCHEvHfRZ87B8jRS+ik+J8yomu5btznv3It7b7kZkymNssKIeXhm0Mq5dqWu
         K+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IkJAPMWkO5FOeNL3Mj+9WKsIqTWMXPw/hrooudOQns=;
        b=Y1gC7uUlR7yaGBqL5YuzUXtqbe1dnyCyMUCwWH9rNZRq0Wgt64IedWo48wy9pLgt1+
         TgIu50748+kLDsVPS5nuvJYP5a9/qvrOEwQsVzY5lqtm/sK9EeGGCuEJUnRAfOTfM09L
         E3BJfo2meP42M0JXXLkmE7P/Ye1wdTesXh0yIvgZBnz0Jb6HTZ5xLXtZjqL06s5zL1jH
         i9ryHcbMzhmU175qJEgSu8pw9jC0EbMrQ4NerDcIMd8dtRV78ZoB+VkX1qd5hieYWfEA
         98IABI1w19eRnarIC17q/GWN8aGDqnoI5x7G4v3Va2s7aMXwkfwRAvNOe4J5xwmwOH8P
         Yazw==
X-Gm-Message-State: ACrzQf3zdKQUYJLN8AA5l4XUc3+32QyOOmsbOKq4W0VZEsVw75Ka68SD
        bQRH6MUIqhICkouiGlxiYjg=
X-Google-Smtp-Source: AMsMyM6nrBzn9BvmDGarhI0IVXpoMaHROpOSRCOg8Pl+EpzbujmE32Ke/rtLlcz9O2arvdNS2lzsyw==
X-Received: by 2002:a5d:59ae:0:b0:236:6861:a89d with SMTP id p14-20020a5d59ae000000b002366861a89dmr15474105wrr.437.1667391107742;
        Wed, 02 Nov 2022 05:11:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c445000b003cf78aafdd7sm2032822wmn.39.2022.11.02.05.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:11:47 -0700 (PDT)
Date:   Wed, 2 Nov 2022 15:11:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg KH <greg@kroah.com>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH hid v11 07/14] HID: bpf: introduce hid_hw_request()
Message-ID: <202210291931.zGXW0epb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025093458.457089-8-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Benjamin,

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Tissoires/Introduce-eBPF-support-for-HID-devices/20221025-173852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git master
patch link:    https://lore.kernel.org/r/20221025093458.457089-8-benjamin.tissoires%40redhat.com
patch subject: [PATCH hid v11 07/14] HID: bpf: introduce hid_hw_request()
config: riscv-randconfig-m041-20221029
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/hid/bpf/hid_bpf_dispatch.c:297 hid_bpf_hw_request() warn: variable dereferenced before check 'ctx' (see line 289)

vim +/ctx +297 drivers/hid/bpf/hid_bpf_dispatch.c

eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  285  noinline int
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  286  hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  287  		   enum hid_report_type rtype, enum hid_class_request reqtype)
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  288  {
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25 @289  	struct hid_device *hdev = (struct hid_device *)ctx->hid; /* discard const */
                                                                                                       ^^^^^^^^
Dereference

eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  290  	struct hid_report *report;
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  291  	struct hid_report_enum *report_enum;
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  292  	u8 *dma_data;
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  293  	u32 report_len;
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  294  	int ret;
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  295  
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  296  	/* check arguments */
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25 @297  	if (!ctx || !hid_bpf_ops || !buf)
                                                             ^^^
Checked too late.

eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  298  		return -EINVAL;
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  299  
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  300  	switch (rtype) {
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  301  	case HID_INPUT_REPORT:
eaf51f2d4f8561 Benjamin Tissoires 2022-10-25  302  	case HID_OUTPUT_REPORT:

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


