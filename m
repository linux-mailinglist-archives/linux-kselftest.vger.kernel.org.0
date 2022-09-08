Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8295B2849
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiIHVRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIHVRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 17:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098DCD21FF;
        Thu,  8 Sep 2022 14:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AC52B822A1;
        Thu,  8 Sep 2022 21:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8E5C433C1;
        Thu,  8 Sep 2022 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662671840;
        bh=v9s/sbwXbN0b5p0MQQ1FPV3KReo58HlFqg6xFDEd62M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ta+norZeD7rlC7HE94dns0X1sl0/IAkAQBZlf/o1jCc8vgo6HoI6sZJzTQIP6wPMw
         QpcJ3R//CiemhE0UA+Bu0E9FfjlQX/JDT6frndDixICBTK+Byc7E2G1zVp6JUcAq5i
         DtEkBoXf1NTEys71HyXHz3s+nMk6qI55jCFVt2BbwaEbbDErbIZpBF+epI54C/dMrE
         4j5aHqlugt4xiwQDzi9lzjTvGKk8+Zj1V7/ju5anLqwVptNDAsEkHrTEDUHs6dbpD9
         u0h61hVOzxxQxGAvCmg4YjNKBKFRmdEZ8PHkjCouz7cpfyQBvfePeIYChZiai0ED/q
         GdRhfUKzyIroA==
Date:   Fri, 9 Sep 2022 00:17:13 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <Yxpb2aBXUZxHZwjb@kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-6-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905020411.17290-6-jarkko@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 05, 2022 at 05:04:11AM +0300, Jarkko Sakkinen wrote:
> +	for (i = 0; i < self->encl.nr_segments; i++) {
> +		struct encl_segment *seg = &self->encl.segment_tbl[i];
> +
> +		total_size += seg->size;
> +	}

This is actually same as:

        struct encl_segment *seg = &self->encl.segment_tbl[self->encl.nr_segments - 1];
        
        total_size = seg->offset + seg->size;

Should I update?

BR, Jarkko
