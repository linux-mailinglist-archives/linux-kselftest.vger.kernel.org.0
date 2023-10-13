Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC67C8E25
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMUGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjJMUGd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 16:06:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B24D6;
        Fri, 13 Oct 2023 13:06:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BE2C433C7;
        Fri, 13 Oct 2023 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697227591;
        bh=J62YA1GAhd+QaRQ3z6JllZRyVbgvVGi3d7oKO5H2ymk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JG9hFy1xtPQdV/+Itj+3tkn+P89MDOPV2SCZlW8jYbsVHF12WRZy4rTL/6+6k7RPX
         RLDnx1q4OqoIMga/KYpz9cLeu7duf44+AGdekioXdnKRWSUzTkqWnRumsTS08s4qSh
         bzEjWRqZYtk1zaYPFtNVAMWhaE7kghIHCwUDtRXfT7oH2ufLPHE8MgEhlNMradWcoq
         qFqeQsRJ628cfNQbo2MWM3Bt34/WncD8A0gQMuKjHQWT0K3pxdYfz+E569wQkEc1ic
         1DtzuyXEV6qnic0jXTzt8gre0Lt+85SFL12Nmh+v9WbOj1PCHrO1HocvYZZuK7qkf3
         gnpXWlkAu1M7Q==
Date:   Fri, 13 Oct 2023 22:06:26 +0200
From:   Simon Horman <horms@kernel.org>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, shuah@kernel.org
Subject: Re: [PATCH net v2 0/4] selftests: openvswitch: Minor fixes for some
 systems
Message-ID: <20231013200626.GS29570@kernel.org>
References: <20231011194939.704565-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 11, 2023 at 03:49:35PM -0400, Aaron Conole wrote:
> A number of corner cases were caught when trying to run the selftests on
> older systems.  Missed skip conditions, some error cases, and outdated
> python setups would all report failures but the issue would actually be
> related to some other condition rather than the selftest suite.
> 
> Address these individual cases.
> 
> Aaron Conole (4):
>   selftests: openvswitch: Add version check for pyroute2
>   selftests: openvswitch: Catch cases where the tests are killed
>   selftests: openvswitch: Skip drop testing on older kernels
>   selftests: openvswitch: Fix the ct_tuple for v4
> 
>  .../selftests/net/openvswitch/openvswitch.sh  | 21 +++++++-
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 48 ++++++++++++++++++-
>  2 files changed, 66 insertions(+), 3 deletions(-)

Thanks Aaron,

this looks like a good incremental improvement to me.

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

