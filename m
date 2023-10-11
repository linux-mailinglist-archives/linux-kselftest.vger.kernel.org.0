Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627447C55AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjJKNlp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjJKNlm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 09:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356FEB7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697031661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnCtsfSMJ0596JXKTEwqnq/8AJhM3PDAMQhE8KTSUnc=;
        b=h8DmasEwoc02hjsSxdSX1HEBpMjPiAmBfIl4TBsoi/0onczls28RkHe2wBYm6fIrkQBkl0
        DMgYlKVtyxtuGn4I7jvfzxwuPSFTpdJigcQ3k4HSHuM45uBKiffq3//QHsKWFxOJRBGj6c
        P9RmeNJ7Bgq3poR5ME4elyuiljOZBZQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-oQYP-2PfPjuItR49lDfaaQ-1; Wed, 11 Oct 2023 09:40:58 -0400
X-MC-Unique: oQYP-2PfPjuItR49lDfaaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FF3A1C0759E;
        Wed, 11 Oct 2023 13:40:57 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD28A21CAC6B;
        Wed, 11 Oct 2023 13:40:56 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net 3/4] selftests: openvswitch: Skip drop testing on
 older kernels
References: <20231006151258.983906-1-aconole@redhat.com>
        <20231006151258.983906-4-aconole@redhat.com>
        <2e7ee087b33fba7e907c76e60d9eaed1807714e2.camel@redhat.com>
Date:   Wed, 11 Oct 2023 09:40:56 -0400
In-Reply-To: <2e7ee087b33fba7e907c76e60d9eaed1807714e2.camel@redhat.com>
        (Paolo Abeni's message of "Tue, 10 Oct 2023 12:29:01 +0200")
Message-ID: <f7ta5spcm53.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

> On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
>> Kernels that don't have support for openvswitch drop reasons also
>> won't have the drop counter reasons, so we should skip the test
>> completely.  It previously wasn't possible to build a test case
>> for this without polluting the datapath, so we introduce a mechanism
>> to clear all the flows from a datapath allowing us to test for
>> explicit drop actions, and then clear the flows to build the
>> original test case.
>> 
>> Fixes: 4242029164d6 ("selftests: openvswitch: add explicit drop testcase")
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  .../selftests/net/openvswitch/openvswitch.sh  | 17 ++++++++++
>>  .../selftests/net/openvswitch/ovs-dpctl.py    | 34 +++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index 2a0112be7ead5..ca7090e71bff2 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -144,6 +144,12 @@ ovs_add_flow () {
>>  	return 0
>>  }
>>  
>> +ovs_del_flows () {
>> +	info "Deleting all flows from DP: sbx:$1 br:$2"
>> +	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
>> +        return 0
>
> The chunk above mixes whitespaces and tabs for indenting, please be
> consistent.

Thanks.  Will fix in v2

> Thanks!
>
> Paolo

