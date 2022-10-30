Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0120361291C
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJ3I3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 04:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3I3v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 04:29:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADB120
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 01:29:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f140so8280557pfa.1
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wn67zjUrvRIAuIt/yH34kPy+6+CbEnri6MP6SVwT/Is=;
        b=Jr71H3plqD0NcrrYdwq7uz80Jp+rK4So+F/8gfGNz+KeVF+pfuD1Ka2tE14wYNniX/
         p7kCpQF54u1qeOBmwB4by0DV+zIZ7SxUW4RWggXHhupamH4rgLtobZNIODPexU3IdT28
         ZmjO3D4jQF2AIyBLSx8DuS1WXjZQY0UeaKU7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wn67zjUrvRIAuIt/yH34kPy+6+CbEnri6MP6SVwT/Is=;
        b=tjDok0Ec7i+A8XNlVeoCZ91rZzuzFfCdco28QHl3M03Nd9XKjrwY0oJgB5cueSsygR
         hItG/rfJXdHFEHhmdbAOgns9qSfEDwT+fHuHQyzxLxjPdWSOcaNZCkCyshGKM9RKhuPb
         UFUSGZkQxzp7Gnsy1R61ZocyBReAnTbpE24EEe1hxVzNcJlDZ5hRbgsDt+YggzHJnA+i
         UJnCR6oY+ssSXZ3DyuUmzm1iVatykK5nLpyQr9TZCrbdLGUxympqGM3o3dReGsFeH3dp
         N79ZQ+NJ4OV7pbHeArkumZq6pBX74vFpkdQtH5h/vlLJ8BNtZ7oN40rEMvVTG2BWyrdm
         8cfQ==
X-Gm-Message-State: ACrzQf3TkKDRMDgWC6eXemQwri3pDZ/nkUGkxfuZllRKMpfLpAoqFtsT
        KExNQOrzL8W/8+svhd69j4QFCQ==
X-Google-Smtp-Source: AMsMyM4CsumDtpL/W71VaqyRQAmwnuQbfM0942cbOIosw7sDXzTn02D8QcnFcAzPyo5WgphUJOuwtg==
X-Received: by 2002:a05:6a00:1810:b0:56b:f29d:cc8e with SMTP id y16-20020a056a00181000b0056bf29dcc8emr8181665pfa.33.1667118586633;
        Sun, 30 Oct 2022 01:29:46 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0f0100b00205fafa6768sm2101042pjy.6.2022.10.30.01.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 01:29:46 -0700 (PDT)
Message-ID: <2dc3fbd9-217b-1e7e-1b77-dad14bce91e0@linuxfoundation.org>
Date:   Sun, 30 Oct 2022 02:29:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] ksefltests: pidfd: Fix wait_states: Test terminated by
 timeout
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, brauner@kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1662001807-7-1-git-send-email-lizhijian@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1662001807-7-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/31/22 21:10, Li Zhijian wrote:
> 0Day/LKP observed that the kselftest blocks forever since one of the
> pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
> the source, we found that it blocks at:
> ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
> 
> wait_states has below testing flow:
>    CHILD                 PARENT
>    ---------------+--------------
> 1 STOP itself
> 2                   WAIT for CHILD STOPPED
> 3                   SIGNAL CHILD to CONT
> 4 CONT
> 5 STOP itself
> 5'                  WAIT for CHILD CONT
> 6                   WAIT for CHILD STOPPED
> 
> The problem is that the kernel cannot ensure the order of 5 and 5', once
> 5 goes first, the test will fail.
> 
> we can reproduce it by:
> $ while true; do make run_tests -C pidfd; done
> 
> Introduce a blocking read in child process to make sure the parent can
> check its WCONTINUED.
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

Sorry for the delay. Now applied to linux-kselftest fixes for rc4

thanks,
-- Shuah
