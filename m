Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF25F652F7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 11:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiLUKbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 05:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiLUKaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 05:30:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE922299
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 02:27:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4C3267373; Wed, 21 Dec 2022 11:27:55 +0100 (CET)
Date:   Wed, 21 Dec 2022 11:27:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in
 user-space tool
Message-ID: <20221221102755.GA25835@lst.de>
References: <20221205135022.49708-1-gbayer@linux.ibm.com> <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com> <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com> <357fa52d-ae0d-ded9-5fd0-c5d15bc06ff9@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357fa52d-ae0d-ded9-5fd0-c5d15bc06ff9@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Can you explain what the problem is?  I just say a maze of quotes
and top posting replies.
