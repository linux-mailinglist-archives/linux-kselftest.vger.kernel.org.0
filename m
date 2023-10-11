Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857257C55A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjJKNlh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjJKNlh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 09:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD298
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697031646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kBo1Q9ZZGOScf2Q/foJ7s3ES0s1m6pzlmqueXFx8NSo=;
        b=U8oA9V59y+6NAzHMW6lgIzsM8evCA0FQRQuyLfC1IpRVgG5KmdNlx3sT8ZaSkzY9yjZRue
        JOHGEDDvH8OsaXVdbzFQfWgwPqgaQxVs7loIBs9nRUcqTGBS2F/pdVYH2rORcNtmgIW/Yl
        PEUXNZfwG7Ro2mOjYwOuxLzwbShYu9U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-6ZWT2-lpM6qY3wHIZZ79Tg-1; Wed, 11 Oct 2023 09:40:42 -0400
X-MC-Unique: 6ZWT2-lpM6qY3wHIZZ79Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 668B7946900;
        Wed, 11 Oct 2023 13:40:42 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEA111C060AE;
        Wed, 11 Oct 2023 13:40:41 +0000 (UTC)
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
Subject: Re: [PATCH net 1/4] selftests: openvswitch: Add version check for
 pyroute2
References: <20231006151258.983906-1-aconole@redhat.com>
        <20231006151258.983906-2-aconole@redhat.com>
        <96bdb031129cdebfa6e0bdd4342439d9d864518b.camel@redhat.com>
Date:   Wed, 11 Oct 2023 09:40:41 -0400
In-Reply-To: <96bdb031129cdebfa6e0bdd4342439d9d864518b.camel@redhat.com>
        (Paolo Abeni's message of "Tue, 10 Oct 2023 12:25:51 +0200")
Message-ID: <f7tedi1cm5i.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

> On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
>> Paolo Abeni reports that on some systems the pyroute2 version isn't
>> new enough to run the test suite.  Ensure that we support a minimum
>> version of 0.6 for all cases (which does include the existing ones).
>> The 0.6.1 version was released in May of 2021, so should be
>> propagated to most installations at this point.
>> 
>> The alternative that Paolo proposed was to only skip when the
>> add-flow is being run.  This would be okay for most cases, except
>> if a future test case is added that needs to do flow dump without
>> an associated add (just guessing).  In that case, it could also be
>> broken and we would need additional skip logic anyway.  Just draw
>> a line in the sand now.
>> 
>> Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://lore.kernel.org/lkml/8470c431e0930d2ea204a9363a60937289b7fdbe.camel@redhat.com/
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 +-
>>  tools/testing/selftests/net/openvswitch/ovs-dpctl.py   | 8 ++++++++
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index 9c2012d70b08e..220c3356901ef 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -525,7 +525,7 @@ run_test() {
>>  	fi
>>  
>>  	if python3 ovs-dpctl.py -h 2>&1 | \
>> -	     grep "Need to install the python" >/dev/null 2>&1; then
>> +	     grep -E "Need to (install|upgrade) the python" >/dev/null 2>&1; then
>>  		stdbuf -o0 printf "TEST: %-60s  [PYLIB]\n" "${tdesc}"
>>  		return $ksft_skip
>>  	fi
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 912dc8c490858..9686ca30d516d 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -28,6 +28,8 @@ try:
>>      from pyroute2.netlink import nlmsg_atoms
>>      from pyroute2.netlink.exceptions import NetlinkError
>>      from pyroute2.netlink.generic import GenericNetlinkSocket
>> +    import pyroute2
>> +
>>  except ModuleNotFoundError:
>>      print("Need to install the python pyroute2 package.")
>>      sys.exit(0)
>> @@ -1998,6 +2000,12 @@ def main(argv):
>>      nlmsg_atoms.ovskey = ovskey
>>      nlmsg_atoms.ovsactions = ovsactions
>>  
>> +    # version check for pyroute2
>> +    prverscheck = pyroute2.__version__.split(".")
>> +    if int(prverscheck[0]) == 0 and int(prverscheck[1]) < 6:
>> +        print("Need to upgrade the python pyroute2 package.")
>
> I think it would be better to propagate/print also the minimum version
> required, so that the user should not have to resort looking at the
> self-test sources to learn the required minimum version.

ACK - makes sense to me.

> Cheers,
>
> Paolo

