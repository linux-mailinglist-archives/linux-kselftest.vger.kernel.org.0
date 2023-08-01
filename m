Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D476BA14
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjHAQyw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHAQyu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 12:54:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B702690;
        Tue,  1 Aug 2023 09:54:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0243F6017E;
        Tue,  1 Aug 2023 18:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690908885; bh=Yx04bmdoZMNOkKPZgrflGP2jjq18mCy2PcLID61NEg4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ry2EiIzf4v6rJBWhXoyUNgQp/WI8xzniFrMPmXFfSDZPVTP5tuRv9Fv2l2KxfFU/o
         RTct1KQoeF5VSiLEshMAbjx4Q3HCDF1zRwwANTmQEohb806K6WWmh3SxuVEfg5P1dE
         s7+Ahb1BJU9WDP7iXTn5iSju68kZcLy1Mb4U5lFboZBRfxYQ6XKX9kX2iO7Ul17031
         Pbmr0pNKEE8AQ7JBVUBu/pjqlGRC5Pt5PFIw+T0G2vgWMMWBAn3w4SYMKLfWg9e9D4
         7aywMYclIkqHj/cp3nq9HPqB/c1fhKwnmWSca95zUEO9SsPzYek1tZ8E5dfilglfuv
         IRPSCUhJTvdAg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ExkLY74uPblc; Tue,  1 Aug 2023 18:54:42 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 9CF676015F;
        Tue,  1 Aug 2023 18:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690908882; bh=Yx04bmdoZMNOkKPZgrflGP2jjq18mCy2PcLID61NEg4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZrNwC/6uMPdjMV2AavDStfBkqP0L9rUdwl6Nmilk31m4RABneeSgiUDTBa/CLdjOA
         rT2BbtzNwHsCg5cI4ulhiV+mKom/d7JNiciPtJ28Qa9NSJzsaLSIRmoi/pqNQAAzBE
         4LNy6MAL95Lz3oppS5T8K0j6TPCPDDt+rr5ViM35dT5avXJ+gSiIPPI+Q6c9FDpvEq
         K6xx7ss1T0xgZ4QDb59CAnKjN27xN4vK/t26LbfoxBmNkdwRtlEV6B3MANQECrVOhf
         K/jIvPo5u+cjdNEDrD3nP7fK4s3uhWq1AomqB6RAxvGTj8e+wVuZBqVqzyzgppqKsu
         foUZ4QJ1raobA==
Message-ID: <304ba960-0214-82d4-05be-e5956baa64c7@alu.unizg.hr>
Date:   Tue, 1 Aug 2023 18:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US
To:     Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@idosch.org>
Cc:     razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder> <875y5zf27p.fsf@nvidia.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <875y5zf27p.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/1/23 13:08, Petr Machata wrote:
> 
> Ido Schimmel <idosch@idosch.org> writes:
> 
>> On Thu, Jul 27, 2023 at 09:26:03PM +0200, Mirsad Todorovac wrote:
>>> not ok 49 selftests: net/forwarding: mirror_gre_changes.sh # exit=1
>>
>> Petr, please take a look. Probably need to make the filters more
>> specific. The failure is:
>>
>> # TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
>> # 	Expected to capture 10 packets, got 14.
> 
> Yeah, this reproduces easily on my laptop. The switches are somehow much
> more quiet and do not really hit the issue.
> 
> Mirsad, can you please try this patch? It fixes the issue for me.
> 
>>From 77461c209eb0067dca7fdf4431a907b2a1ce8c6a Mon Sep 17 00:00:00 2001
> Message-ID: <77461c209eb0067dca7fdf4431a907b2a1ce8c6a.1690887929.git.petrm@nvidia.com>
> From: Petr Machata <petrm@nvidia.com>
> Date: Tue, 1 Aug 2023 12:57:53 +0200
> Subject: [PATCH net-next] selftests: mirror_gre_changes: Tighten up the TTL
>   test match
> To: <netdev@vger.kernel.org>
> 
> This test verifies whether the encapsulated packets have the correct
> configured TTL. It does so by sending ICMP packets through the test
> topology and mirroring them to a gretap netdevice. On a busy host
> however, more than just the test ICMP packets may end up flowing
> through the topology, get mirrored, and counted. This leads to
> potential spurious failures as the test observes much more mirrored
> packets than the sent test packets, and assumes a bug.
> 
> Fix this by tightening up the mirror action match. Change it from
> matchall to a flower classifier matching on ICMP packets specifically.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   tools/testing/selftests/net/forwarding/mirror_gre_changes.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> index aff88f78e339..5ea9d63915f7 100755
> --- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> +++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> @@ -72,7 +72,8 @@ test_span_gre_ttl()
>   
>   	RET=0
>   
> -	mirror_install $swp1 ingress $tundev "matchall $tcflags"
> +	mirror_install $swp1 ingress $tundev \
> +		"prot ip flower $tcflags ip_prot icmp"
>   	tc filter add dev $h3 ingress pref 77 prot $prot \
>   		flower skip_hw ip_ttl 50 action pass
>   

The problem seems to be fixed in the test run:

root@defiant:tools/testing/selftests/net/forwarding# ./mirror_gre_changes.sh
TEST: mirror to gretap: TTL change (skip_hw)                        [ OK ]
TEST: mirror to ip6gretap: TTL change (skip_hw)                     [ OK ]
TEST: mirror to gretap: tunnel down/up (skip_hw)                    [ OK ]
TEST: mirror to ip6gretap: tunnel down/up (skip_hw)                 [ OK ]
TEST: mirror to gretap: egress down/up (skip_hw)                    [ OK ]
TEST: mirror to ip6gretap: egress down/up (skip_hw)                 [ OK ]
TEST: mirror to gretap: remote address change (skip_hw)             [ OK ]
TEST: mirror to ip6gretap: remote address change (skip_hw)          [ OK ]
TEST: mirror to gretap: tunnel deleted (skip_hw)                    [ OK ]
TEST: mirror to ip6gretap: tunnel deleted (skip_hw)                 [ OK ]
TEST: mirror to gretap: underlay route removal (skip_hw)            [ OK ]
TEST: mirror to ip6gretap: underlay route removal (skip_hw)         [ OK ]
WARN: Could not test offloaded functionality
root@defiant:tools/testing/selftests/net/forwarding#

That leaves us with one more tests to fix:./bridge_vlan_mcast.sh

# ./bridge_vlan_mcast.sh

TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
         Wrong default mcast_startup_query_interval global vlan option value


[...]

+ bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_last_member_interval 100
+ for current_test in ${TESTS:-$ALL_TESTS}
+ vlmc_startup_query_test
+ RET=0
++ bridge -j vlan global show
+ local 'goutput=[{"ifname":"br0","vlans":[{"vlan":1,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_
interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000},{"vlan":10,"vlanEnd":11,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_versi
on":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_respons
e_interval":1000}]}]'
+ jq -e '.[].vlans[] | select(.vlan == 10)'
+ echo -n '[{"ifname":"br0","vlans":[{"vlan":1,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interv
al":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000},{"vlan":10,"vlanEnd":11,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,
"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_inte
rval":1000}]}]'
+ check_err 0 'Could not find vlan 10'\''s global options'
+ local err=0
+ local 'msg=Could not find vlan 10'\''s global options'
+ [[ 0 -eq 0 ]]
+ [[ 0 -ne 0 ]]
+ jq -e '.[].vlans[] | select(.vlan == 10 and                                       .mcast_startup_query_interval == 3125) '
+ echo -n '[{"ifname":"br0","vlans":[{"vlan":1,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interv
al":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000},{"vlan":10,"vlanEnd":11,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,
"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_inte
rval":1000}]}]'
+ check_err 4 'Wrong default mcast_startup_query_interval global vlan option value'
+ local err=4
+ local 'msg=Wrong default mcast_startup_query_interval global vlan option value'
+ [[ 0 -eq 0 ]]
+ [[ 4 -ne 0 ]]
+ RET=4
+ retmsg='Wrong default mcast_startup_query_interval global vlan option value'
+ log_test 'Vlan mcast_startup_query_interval global option default value'
+ local 'test_name=Vlan mcast_startup_query_interval global option default value'
+ local opt_str=
+ [[ 1 -eq 2 ]]
+ [[ 4 -ne 0 ]]
+ EXIT_STATUS=1
+ printf 'TEST: %-60s  [FAIL]\n' 'Vlan mcast_startup_query_interval global option default value '
TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
+ [[ ! -z Wrong default mcast_startup_query_interval global vlan option value ]]
+ printf '\t%s\n' 'Wrong default mcast_startup_query_interval global vlan option value'
         Wrong default mcast_startup_query_interval global vlan option value

[...]

Hope this helps.

Kind regards,
Mirsad
