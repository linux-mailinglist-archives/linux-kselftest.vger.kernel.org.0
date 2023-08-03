Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579B376E3FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjHCJKp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjHCJKo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 05:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E142A2;
        Thu,  3 Aug 2023 02:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB5061D03;
        Thu,  3 Aug 2023 09:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57743C433C7;
        Thu,  3 Aug 2023 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053842;
        bh=QRI50CvVsw1NT2bo2BmJ3RMA6/s1sNXqJePF55C23xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2NF9Mmy9HNWVSooHJy4u0VnvdRathY14zCjJwP4pxRH33eQ+Uvb1Rtjz/unrAWFn
         Ffx8S6aEjyggLx0xl72k2Ygtcm2TjWR1MygYLC8ELBW3zS4YQJuIzfoTvDTSCb4sbL
         Jhm1IQ7j+NL7iNbLVPtzpBQTtm8WONIEDMjTf1Y6o+Nz+CsSBespmUvZOoOX40faMr
         Lr+4WiRCinAfICjKmIdJcZJZNeSF8jldtOKAbpHRnyYiauErOoyJagTcJbB3Gu9x1T
         1eDLwh2VhfKV9opqF/H0tWY/pM435MN7978zyxRDvSiMpJlfs618UQ9SJd7R+nQnEd
         fhCxkognvL9Ag==
Date:   Thu, 3 Aug 2023 11:10:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH v3 net-next 0/5] selftests: openvswitch: add
 flow programming cases
Message-ID: <ZMtvDiiD9qv123ps@kernel.org>
References: <20230801212226.909249-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 05:22:21PM -0400, Aaron Conole wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
> 
> Add the ability to program some of the more common flows with actions. This
> can be improved overtime to include regression testing, etc.

Thanks Aaron.

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

