Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBE5C7F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 05:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGBDrh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 23:47:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726768AbfGBDrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 23:47:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x623kUcD076836
        for <linux-kselftest@vger.kernel.org>; Mon, 1 Jul 2019 23:47:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfxgqt6x1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2019 23:47:35 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Jul 2019 04:47:35 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Jul 2019 04:47:31 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x623lUXt54460762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 03:47:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72336B2067;
        Tue,  2 Jul 2019 03:47:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51694B2065;
        Tue,  2 Jul 2019 03:47:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.179.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jul 2019 03:47:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1F3C216C3620; Mon,  1 Jul 2019 20:47:30 -0700 (PDT)
Date:   Mon, 1 Jul 2019 20:47:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 1/3] rcu: Expedite the rcu quiescent state reporting if
 help needed
Reply-To: paulmck@linux.ibm.com
References: <20190701040415.219001-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701040415.219001-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070203-0064-0000-0000-000003F5F3B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011363; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226195; UDB=6.00645517; IPR=6.01007407;
 MB=3.00027546; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-02 03:47:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070203-0065-0000-0000-00003E1B39A1
Message-Id: <20190702034730.GI26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020040
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 01, 2019 at 12:04:13AM -0400, Joel Fernandes (Google) wrote:
> The t->rcu_read_unlock_special union's need_qs bit can be set by the
> scheduler tick (in rcu_flavor_sched_clock_irq) to indicate that help is
> needed from the rcu_read_unlock path. When this help arrives however, we
> can do better to speed up the quiescent state reporting which if
> rcu_read_unlock_special::need_qs is set might be quite urgent. Make use
> of this information in deciding when to do heavy-weight softirq raising
> where possible.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Cute thought, but I am going to have to pass on this one.  The reason
is that by the time that ->rcu_read_unlock_special.b.need_qs gets set,
the grace period is already one full second old.  At that point, the
extra tick of waiting is down in the noise.

Right now, we do the extra work if we really are blocking an expedited
grace period (the first two lines of the original condition) or we are
running on a nohz_full CPU (which might never execute a scheduling clock
tick, thus potentially delaying forever).  And expedited grace periods
are supposed to complete in tens or maybe hundreds of microseconds,
assuming the RCU readers are being cooperative, which is a whole
different level of urgent.

Nevertheless, thank you for looking into this!

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c588ef98efd3..bff6410fac06 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -622,7 +622,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		t->rcu_read_unlock_special.b.exp_hint = false;
>  		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
>  		      (rdp->grpmask & rnp->expmask) ||
> -		      tick_nohz_full_cpu(rdp->cpu);
> +		      tick_nohz_full_cpu(rdp->cpu)  ||
> +		      t->rcu_read_unlock_special.b.need_qs;
>  		// Need to defer quiescent state until everything is enabled.
>  		if (irqs_were_disabled && use_softirq &&
>  		    (in_interrupt() ||
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

